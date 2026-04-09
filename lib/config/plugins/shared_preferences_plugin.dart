import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPlugin {
  static Future<SharedPreferences> get _instance async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = await _instance;
    await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await _instance;
    return prefs.getBool(key) ?? true;
  }
}
