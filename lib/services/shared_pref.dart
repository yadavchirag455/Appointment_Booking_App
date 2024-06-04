import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  Future<bool> saveUserId(String userId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(userIdKey, userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userIdKey);
  }

  //==========================================================================
  Future<bool> saveUserDisplayName(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(userNameKey, userName);
  }

  Future<String?> getUserDisplayName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userNameKey);
  }

  //==========================================================================
  Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(userEmailKey, userEmail);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userEmailKey);
  }
}
