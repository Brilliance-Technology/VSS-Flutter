import 'package:get/get.dart';

class ProductTileController extends GetxController {
  var isProgressBarOn = false.obs;

  void progressBarOnAndOff(bool condition) {
    if (condition == false)
      isProgressBarOn.value = true;
    else
      isProgressBarOn.value = false;
  }
}
