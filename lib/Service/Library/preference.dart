import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  Future<void> init() async =>
      preferences = await SharedPreferences.getInstance();

  void clearAll() => preferences.clear();

  // userID
  void setUserID({required String value}) =>
      preferences.setString('userID', value);
  String? getUserID() => preferences.getString('userID');
  void removeUserID() => preferences.remove('userID');
}
