import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocalStorage {
  LocalStorage(this._secureStorage, this._sharedPreferences);

  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  /// Keys for local storage
  static const String token = 'token';
  static const String user = 'user';
  static const String theme = 'theme';
  static const String language = 'language';

  Future<void> saveToken(String value) async {
    await _secureStorage.write(key: token, value: value);
  }

  Future<String> getToken() async {
    return await _secureStorage.read(key: token) ?? '';
  }

  Future<void> saveTheme(String value) async {
    await _sharedPreferences.setString(theme, value);
  }

  String getTheme() {
    return _sharedPreferences.getString(theme) ?? '';
  }
}
