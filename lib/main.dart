import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/firebase_options.dart';
import 'package:ecommerce_mobile_app/router/app_router.dart';
import 'package:ecommerce_mobile_app/services/remote/notification_service.dart';
import 'package:ecommerce_mobile_app/services/remote/remote_config_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Your power = AI power * your knowlege
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Register the top-level background handler before DI
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await configureDependencies();

    // Initialize Remote Config (fetch & activate feature flags)
    await getIt<RemoteConfigService>().initialize();

    // Initialize notification service (permissions, handlers, token)
    await getIt<NotificationService>().initialize();
  } catch (e) {
    if (getIt.isRegistered<AppLogger>()) {
      getIt<AppLogger>().e('App initialization failed', error: e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
