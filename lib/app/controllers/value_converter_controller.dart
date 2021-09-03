import 'package:get/get.dart';

class ValueConverterController extends GetxController {
  @override
  void onClose() {
    incheToMM.value = 0.0;
    totalInchesToMM.value = 0.0;

    super.onClose();
  }

  var incheToMM = 0.0.obs;
  var totalInchesToMM = 0.0.obs;

  void inchesToMM(double inch) {
    incheToMM.value = inch * 25.4;

    print("MM :${incheToMM.value}");
  }

  feetToMM(double feet) {
    totalInchesToMM.value = feet * 12 * 25.4;

    print("Inches :${totalInchesToMM.value}");
  }
}
