import 'package:get/get.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/data/models/ready_made_model.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/app/data/services/orders_service.dart';

class ReadMadeOrderController extends GetxController {
  AppPrefs _appPrefs = AppPrefs();
  UserModel _userModel;
  var isUserDispachInCharge=false.obs;
  @override
  void onInit() {
    getAllReadyMadeOrders();
    checkUserRole();
    super.onInit();
  }

  checkUserRole()async{
    try {
      UserModel user = await _appPrefs.readUser(Constants.user_key);
      // print(user.data.token);

      _userModel = user;
      print(_userModel.data.role);
      if (int.tryParse(_userModel.data.role) == 4) {
        isUserDispachInCharge.value = true;
      } else {
        isUserDispachInCharge.value = false;
      }

    } catch (e) {
      print(e);
    }
}
  var isLoading = true.obs;
  OrderService _orderService = OrderService();
  var readymadeOrdersList = List<ReadyMade>.empty(growable: true).obs;

  getAllReadyMadeOrders() async {
    try {
      readymadeOrdersList.clear();
      final ReadyMadeResponse response =
          await _orderService.getReadymadeOrders();
      // if (response.orderList == 200) {
      //   print("Order Created: $response");
      // }
      readymadeOrdersList.value = response.res.toList();
      readymadeOrdersList.forEach((element) {
        print("\n");
        print(element.toJson());
      });
      isLoading(false);
    } catch (e) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // showCustomDialog(context, 'Error', errorMessage);
      print(e);
      isLoading(false);
    }
  }
}
