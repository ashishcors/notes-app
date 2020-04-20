import 'dart:convert';

import 'package:notesapp/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static const _keyDarkMode = 'KeyDarkMode';
  static const _keyUserData = 'KeyUserData';

  bool get darkMode => _getFromDisk(_keyDarkMode) ?? false;

  set darkMode(bool value) => _saveToDisk(_keyDarkMode, value);

  User get userData {
    try {
      return User.fromJson(json.decode(_getFromDisk(_keyUserData)));
    } catch (_) {
      return null;
    }
  }

  set userData(User user) =>
      _saveToDisk(_keyUserData, json.encode(user.toMap()));

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    print(
        '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
