import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/SalesDashBoard/sales_dashboard._model.dart';
import 'package:inventory_management/app/data/models/pi_chart_model.dart';
import 'package:inventory_management/app/data/models/total_count.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/app/data/services/dash_board_service.dart';
import 'package:inventory_management/meta/screens/login/login_screen.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';

class DashBoardController extends GetxController {
  var touchedIndex = 0.obs;

  var isUserLoaded = false.obs;
  var totalCountsAll = TotalCounts().obs;
  var soldProductPieList = List<PieProduct>.empty(growable: true);
  var availableProductPieList = List<PieProduct>.empty(growable: true);
  var totalSalesRate = 0.0.obs;
  var isSalesDataLoaded = false.obs;
  DashBoardService _dashBoardService = DashBoardService();
  AppPrefs _appPrefs = AppPrefs();
  final formater = DateFormat('yyyy-MM-dd');
  var userModel = UserModel().obs;
  getSalesManagerDashboardData(String startDate) async {
    isSalesDataLoaded.value = false;
    AppPrefs appPrefs = AppPrefs();
    var user = await appPrefs.readUser(Constants.user_key);
    try {
      soldProductPieList.clear();
      availableProductPieList.clear();

      String endDate = formater.format(DateTime.now()).toString();

      print("End Date $endDate");
      print("Current Date$startDate");

      PieChartModel response = await _dashBoardService.getPieChartDataBySalesId(
          salesID: user.data.id, startDate: startDate, endDate: endDate);
      await getAllTotalCounts(user.data.role, user.data.id);
      if (response.status == 200) {
        print("Sales edit response $response");

        if ((response.soldProduct.isNotEmpty && response.soldProduct != null) &&
            (response.availableProduct.isNotEmpty) &&
            response.availableProduct != null) {
          soldProductPieList.addAll(response.soldProduct.toList());
          availableProductPieList.addAll(response.availableProduct.toList());
        }
      }
    } catch (e) {
      print(e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(Get.context, 'Error', errorMessage, () {
        Navigator.of(Get.context).pop();
      });
    } finally {
      print("is Sales Data Loaded :${isSalesDataLoaded.value}");
      isSalesDataLoaded.value = true;
      print("is Sales Data Loaded :${isSalesDataLoaded.value}");
    }
  }

  getAllTotalCounts(String role, String salesId) async {
    if (role == "1") {
      TotalCounts response =
          await _dashBoardService.getTotalAllCountsById(salesID: salesId);
      if (response.status == 200) {
        totalCountsAll.value = response;
      }
    } else {
      TotalCounts response = await _dashBoardService.getTotalAllCounts();
      if (response.status == 200) {
        totalCountsAll.value = response;
      }
    }
  }

  loadSharedPrefs() async {
    try {
      userModel.value = await _appPrefs.readUser(Constants.user_key);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: new Text("User Loaded: ${user.data.firstName}"),
      //     duration: const Duration(milliseconds: 500)));
      //print(user.data.token);
      if (userModel.value == null) {
        Get.offAll(LoginScreen());
      } else
        isUserLoaded.value = true;
      // print("Current User ROle:" + userModel.value.data.role);
    } catch (e) {
      print(e);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: new Text("Nothing found!"),
      //     duration: const Duration(milliseconds: 500)));
    }
  }
}

