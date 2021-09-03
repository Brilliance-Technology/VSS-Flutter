import 'package:get/get.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';

class CartItemTileController extends GetxController
{
  AppPrefs _appPrefs = AppPrefs();
  UserModel userModel;
  var isUserProductionInCharge=false.obs;
  @override
  void onInit() {
checkUserRole();
 
    super.onInit();
  }
  checkUserRole()async{
    try {
      UserModel user = await _appPrefs.readUser(Constants.user_key);
      // print(user.data.token);

      userModel = user;
      if (int.tryParse(userModel.data.role) == 3) {
        isUserProductionInCharge.value = true;
      } else {
        isUserProductionInCharge.value = false;
      }

    } catch (e) {
      print(e);
    }
  }
}