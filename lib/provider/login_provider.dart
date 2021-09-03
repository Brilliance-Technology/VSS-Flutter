import 'package:flutter/material.dart';

import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/app/data/services/auth_service.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';
import 'package:page_transition/page_transition.dart';

class LoginProvider extends ChangeNotifier {
  AuthService _authService = AuthService();
  AppPrefs _appPrefs = AppPrefs();

  bool isLoading = false;

  UserModel _userModel;
  UserModel get user => _userModel;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loginUser(
      {BuildContext context, int phoneNumber, String password}) async {
    setLoading(true);

    try {
      final UserModel response = await _authService.loginUser(
          phoneNumber: phoneNumber, password: password);
      print("Login Success: $response");
      _userModel = response;
      setLoading(false);
      _appPrefs.saveUser(Constants.user_key, response);

      Navigator.pushReplacement(
        context,
        PageTransition(
          duration: Duration(milliseconds: 500),
          child: HomeScreen(),
          type: PageTransitionType.leftToRight,
        ),
      );
    } catch (e) {
      setLoading(false);
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(e.toString());
      showCustomDialog(context, 'Error', errorMessage, () {
        Navigator.of(context).pop();
      });
    }
  }
}
