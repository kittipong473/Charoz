import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  Future<void> init() async =>
      preferences = await SharedPreferences.getInstance();

  void setString(String key, String value) => preferences.setString(key, value);

  void setInt(String key, int value) => preferences.setInt(key, value);

  void setDouble(String key, double value) => preferences.setDouble(key, value);

  void setBool(String key, bool value) => preferences.setBool(key, value);

  void setList(String key, List<String> value) =>
      preferences.setStringList(key, value);

  String? getString(String key) => preferences.getString(key);

  int? getInt(String key) => preferences.getInt(key);

  double? getDouble(String key) => preferences.getDouble(key);

  bool? getBool(String key) => preferences.getBool(key);

  List<String>? getList(String key) => preferences.getStringList(key);

  void clearValue(String key) => preferences.remove(key);

  void clearAll() => preferences.clear();
}
