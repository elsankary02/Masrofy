import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  SPService._();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---------------- String ----------------
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  static String? getString(String key) => _prefs.getString(key);

  // ---------------- Bool ----------------
  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static bool? getBool(String key) => _prefs.getBool(key);

  // ---------------- Int ----------------
  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static int? getInt(String key) => _prefs.getInt(key);

  // ---------------- Double ----------------
  static Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  static double? getDouble(String key) => _prefs.getDouble(key);

  // ---------------- List<String> ----------------
  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  // ---------------- Utility ----------------
  /// Whether [key] has a saved value at all.
  static bool containsKey(String key) => _prefs.containsKey(key);

  /// Remove a single key.
  static Future<bool> remove(String key) => _prefs.remove(key);

  /// Wipe everything saved (use with caution — e.g. on logout/reset).
  static Future<bool> clear() => _prefs.clear();
}
