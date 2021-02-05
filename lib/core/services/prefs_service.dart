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

  static const _keyUserId = 'KeyUserId';
  static const _keyIsEmailVerified = 'KeyIsEmailVerified';

  String get userId {
    try {
      return _getFromDisk(_keyUserId);
    } catch (_) {
      return null;
    }
  }

  set userId(String userId) {
    _saveToDisk(_keyUserId, userId);
  }

  bool get isEmailVerified {
    try {
      return _getFromDisk(_keyIsEmailVerified) ?? false;
    } catch (_) {
      return false;
    }
  }

  set isEmailVerified(bool isEmailVerified) {
    _saveToDisk(_keyIsEmailVerified, isEmailVerified);
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

  Future<void> clear() {
    return _preferences.clear();
  }
}
