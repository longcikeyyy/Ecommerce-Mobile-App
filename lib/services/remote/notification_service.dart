import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Top-level background message handler.
/// Must be a top-level function (not a class method) for Firebase Messaging.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase is already initialized in main.dart before this is registered.
  // If you need to show a local notification here, you can instantiate
  // FlutterLocalNotificationsPlugin directly.
  if (kDebugMode) {
    print('Background message received: ${message.messageId}');
  }
}

/// Channel definition for Android high-importance notifications.
const AndroidNotificationChannel _highImportanceChannel =
    AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

@LazySingleton()
class NotificationService {
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseFirestore _firestore;
  final AppLogger _logger;

  NotificationService(
    this._messaging,
    this._localNotifications,
    this._firestore,
    this._logger,
  );

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  /// Call once after DI is ready (typically in main.dart).
  Future<void> initialize() async {
    // 1. Create Android notification channel
    await _createAndroidChannel();

    // 2. Initialize flutter_local_notifications
    await _initLocalNotifications();

    // 3. Request permission from the user
    await requestPermission();

    // 4. Setup message handlers for all 3 app states
    _setupForegroundHandler();
    _setupMessageOpenedAppHandler();
    await _handleInitialMessage();

    // 5. Get & persist the FCM token, listen for refreshes
    await _initToken();

    _logger.i('NotificationService initialized');
  }

  // ---------------------------------------------------------------------------
  // Permission
  // ---------------------------------------------------------------------------

  /// Request notification permission on iOS & Android 13+.
  /// Returns `true` if the user granted permission.
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    _logger.i('Notification permission: ${settings.authorizationStatus}');
    return granted;
  }

  // ---------------------------------------------------------------------------
  // FCM Token management
  // ---------------------------------------------------------------------------

  /// Get the current FCM token.
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      _logger.d('FCM token: $token');
      return token;
    } catch (e, s) {
      _logger.e('Failed to get FCM token', error: e, stackTrace: s);
      return null;
    }
  }

  /// Save the token to Firestore under the current user's document.
  /// Call this after the user has signed in.
  Future<void> saveTokenToServer(String userId) async {
    final token = await getToken();
    if (token == null) return;

    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmTokens': FieldValue.arrayUnion([token]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      _logger.i('FCM token saved for user $userId');
    } catch (e, s) {
      _logger.e('Failed to save FCM token', error: e, stackTrace: s);
    }
  }

  /// Remove a specific token (e.g. on sign-out).
  Future<void> removeTokenFromServer(String userId) async {
    final token = await getToken();
    if (token == null) return;

    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmTokens': FieldValue.arrayRemove([token]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      _logger.i('FCM token removed for user $userId');
    } catch (e, s) {
      _logger.e('Failed to remove FCM token', error: e, stackTrace: s);
    }
  }

  /// Subscribe to a topic (e.g. "promotions", "news").
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    _logger.i('Subscribed to topic: $topic');
  }

  /// Unsubscribe from a topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    _logger.i('Unsubscribed from topic: $topic');
  }

  // ---------------------------------------------------------------------------
  // Private — Initialization helpers
  // ---------------------------------------------------------------------------

  Future<void> _createAndroidChannel() async {
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_highImportanceChannel);
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _initToken() async {
    // Get initial token
    final token = await getToken();
    _logger.d('Initial FCM token: $token');

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      _logger.i('FCM token refreshed: $newToken');
      // In a real app, re-save to your backend here.
      // You can emit an event or call saveTokenToServer if userId is available.
    });
  }

  // ---------------------------------------------------------------------------
  // Private — Message handlers for 3 app states
  // ---------------------------------------------------------------------------

  /// **Foreground**: App is open and in focus.
  /// Firebase won't show a notification automatically, so we use
  /// flutter_local_notifications to display it.
  void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _logger.i('Foreground message: ${message.messageId}');
      _showLocalNotification(message);
    });
  }

  /// **Background → Opened**: User tapped a notification while the app was
  /// in the background (but not terminated).
  void _setupMessageOpenedAppHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _logger.i('Notification opened app: ${message.messageId}');
      _handleMessageNavigation(message);
    });
  }

  /// **Terminated → Opened**: The app was killed; the user tapped a
  /// notification to launch it.
  Future<void> _handleInitialMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _logger.i('App opened from terminated via notification');
      _handleMessageNavigation(initialMessage);
    }
  }

  // ---------------------------------------------------------------------------
  // Private — Display & navigation
  // ---------------------------------------------------------------------------

  /// Show a local notification when a foreground FCM message arrives.
  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    final android = notification.android;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _highImportanceChannel.id,
          _highImportanceChannel.name,
          channelDescription: _highImportanceChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: android?.smallIcon ?? '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  /// Handle navigation when the user taps a notification.
  /// Customize this based on your `message.data` payload.
  void _handleMessageNavigation(RemoteMessage message) {
    final data = message.data;
    _logger.d('Navigating from notification data: $data');

    // Example: navigate based on a "route" key in the payload.
    // final route = data['route'];
    // if (route != null) {
    //   navigatorKey.currentState?.pushNamed(route);
    // }
  }

  /// Callback when user taps a local notification.
  void _onNotificationTapped(NotificationResponse response) {
    _logger.d('Local notification tapped: ${response.payload}');

    if (response.payload != null && response.payload!.isNotEmpty) {
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        _logger.d('Notification payload: $data');
        // Navigate based on payload — same logic as _handleMessageNavigation
      } catch (e) {
        _logger.e('Failed to parse notification payload', error: e);
      }
    }
  }
}
