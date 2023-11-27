import 'package:fms/core/utils/pref_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> setToken(String? token) {
    return _sharedPreferences.setStringOrClear(_keyToken, token);
  }

  String? getToken() {
    return _sharedPreferences.getString(_keyToken);
  }

  Future<bool> setRefreshToken(String? token) {
    return _sharedPreferences.setStringOrClear(_keyRefreshToken, token);
  }

  String? getUsername() {
    return _sharedPreferences.getString(_username);
  }

  String? getPassword() {
    return _sharedPreferences.getString(_password);
  }

  Future<bool> setUsername(String? username) {
    return _sharedPreferences.setStringOrClear(_username, username);
  }

  Future<bool> setPassword(String? password) {
    return _sharedPreferences.setStringOrClear(_password, password);
  }

  Future<bool> setUserId(String? nik) {
    return _sharedPreferences.setStringOrClear(_userId, nik);
  }

  Future<bool> setRoleId(int? roleId) {
    return _sharedPreferences.setIntOrClear(_roleId, roleId);
  }

  Future<bool> setName(String? username) {
    return _sharedPreferences.setStringOrClear(_keyName, username);
  }

  Future<bool> setNik(String? username) {
    return _sharedPreferences.setStringOrClear(_keyNik, username);
  }

  Future<bool> setProjectSite(String? username) {
    return _sharedPreferences.setStringOrClear(_projectSite, username);
  }

  /// Preferences Keys
  static const String _keyToken = 'token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _username = 'username';
  static const String _password = 'password';
  static const String _userId = 'user_id';
  static const String _roleId = 'role_id';

  /// Profile Keys
  static const String _keyName = 'name';
  static const String _keyNik = 'nik';
  static const String _projectSite = 'project_site';
}
