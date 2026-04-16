import 'dart:async';

import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

class RemoteConfigKey {
  static const isShowContinueWithFBSignUpFeature =
      'isShowContinueWithFBSignUpFeature';

  RemoteConfigKey._();
}

@LazySingleton()
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  final AppLogger _logger;

  RemoteConfigService(this._remoteConfig, this._logger);

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: Duration.zero,
        ),
      );

      await _remoteConfig.setDefaults({
        RemoteConfigKey.isShowContinueWithFBSignUpFeature: true,
      });

      final activated = await _remoteConfig.fetchAndActivate();
      _logger.i(
        'Remote Config initialized — activated: $activated, '
        '${RemoteConfigKey.isShowContinueWithFBSignUpFeature}: '
        '${_remoteConfig.getBool(RemoteConfigKey.isShowContinueWithFBSignUpFeature)}',
      );
    } catch (e, st) {
      _logger.e('Remote Config initialization failed', error: e, stackTrace: st);
    }
  }

  /// Stream that emits updated keys whenever Remote Config values change
  /// in real-time. Each event automatically activates the new values.
  Stream<Set<String>> get onConfigUpdated =>
      _remoteConfig.onConfigUpdated.asyncMap((event) async {
        await _remoteConfig.activate();
        _logger.i('Remote Config updated — keys: ${event.updatedKeys}');
        return event.updatedKeys;
      });

  bool getBool(String key) => _remoteConfig.getBool(key);

  bool get isShowContinueWithFBSignUpFeature =>
      getBool(RemoteConfigKey.isShowContinueWithFBSignUpFeature);
}
