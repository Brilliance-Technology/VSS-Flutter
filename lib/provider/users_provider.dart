import 'package:flutter/material.dart';
import 'package:inventory_management/app/data/models/users_list_model.dart';
import 'package:inventory_management/app/data/services/auth_service.dart';

class UsersProvider extends ChangeNotifier {
  AuthService _authService = AuthService();

  UsersListResponse _usersListResponse;

  List<Re> get usersList =>
      _usersListResponse == null ? [] : _usersListResponse.res;

  bool isLoading = false;
  bool isInChargeListLoaded = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  UsersProvider() {
    getAllPI();
  }

  Future<void> getAllPI() async {
    setLoading(true);
    try {
      final UsersListResponse response = await _authService.getAllPI();
      isInChargeListLoaded = true;
      // if (response.orderList == 200) {
      //   print("Order Created: $response");
      // }
      if (response.status == 200) {
        _usersListResponse = response;
      }
      setLoading(false);
    } catch (e) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // showCustomDialog(context, 'Error', errorMessage);
      print(e);
      setLoading(false);
    }
  }
}
