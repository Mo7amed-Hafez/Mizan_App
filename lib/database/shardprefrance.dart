import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;

  static Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> storeData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    } else {
      return false;
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  static Future<bool> containData({required String key}) async {
    return sharedPreferences.containsKey(key);
  }
}
