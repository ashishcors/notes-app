import 'dart:convert';

import 'package:notesapp/src/models/user.dart';
import 'package:notesapp/src/models/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService _instance;
  static SharedPreferences _preferences;

  static Future<PrefsService> getInstance() async {
    if (_instance == null) {
      _instance = PrefsService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static const _keyUserData = 'KeyUserData';
  static const _keyUserPreferences = 'KeyUserPreferences';

  User get userData {
    try {
      return User.fromJson(json.decode(_getFromDisk(_keyUserData)))
        ..userPreferences = userPreferences;
    } catch (_) {
      return null;
    }
  }

  set userData(User user) {
    _saveToDisk(_keyUserData, json.encode(user.toMap()));
    if (user.userPreferences != null)
      _saveToDisk(
        _keyUserPreferences,
        json.encode(user.userPreferences.toMap()),
      );
  }

  UserPreferences get userPreferences {
    try {
      return UserPreferences.fromJson(
          json.decode(_getFromDisk(_keyUserPreferences)));
    } catch (_) {
      return UserPreferences();
    }
  }

  set userPreferences(UserPreferences preferences) =>
      _saveToDisk(_keyUserPreferences, json.encode(preferences.toMap()));

  void clearAllData(){
    _preferences.clear();
  }

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
