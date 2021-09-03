import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppPrefs {
  UserModel _userModel;

  UserModel get currentUser => _userModel;

  String get authToken => currentUser.data.token;

  Future<UserModel> readUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap;
    final String userStr = prefs.getString(key);
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }

    if (userMap != null) {
      final UserModel user = UserModel.fromJson(userMap);
      print(user);
      _userModel = user;
      return user;
    }
    return null;
  }

  saveUser(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
    print("Saved");
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    print("User Logout");
  }
}
