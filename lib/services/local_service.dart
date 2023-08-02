import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static final LocalService _instance = LocalService();
  factory LocalService() => _instance;

  static SharedPreferences? _sharedPreferences;

  static const String _userIdKey = 'userId';

  static Future<void> _setSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> clearSharedPreferences() async {
    if (_sharedPreferences == null) return;
    await _sharedPreferences!.clear();
  }

  static Future<void> clearUserId() async {
    if (_sharedPreferences == null) return;
    await _sharedPreferences!.remove(_userIdKey);
  }

  static Future<void> saveUserId(String userId) async {
    try {
      if (_sharedPreferences == null) {
        await _setSharedPreferences();
      }
      await _sharedPreferences?.setString(_userIdKey, userId);
    } catch (e) {
      log('LocalService - saveUserId Failed : $e');
    }
  }

  static Future<String?> getUserId() async {
    try {
      if (_sharedPreferences == null) {
        await _setSharedPreferences();
      }
      return _sharedPreferences?.getString(_userIdKey);
    } catch (e) {
      log('LocalService - getUserId Failed : $e');
      return null;
    }
  }
}
