import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/create_order_response.dart';
import 'package:inventory_management/app/data/models/order_date_response.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/app/data/services/orders_service.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';

class OrderController extends GetxController {
  //var isScrolling = false.obs;
  var isFetching = false.obs;
  ScrollController scrollController = ScrollController();
  UserModel _userModel;
  var userModel = UserModel().obs;
  AppPrefs _appPrefs = AppPrefs();
  orderListView() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        print("List over ");
        print("Current Page ${currentPage.value}");
        // print("totalPage ${totalPage.value}");
        print(orderList.length);

        await pageFetch();

        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  loadSharedPrefs() async {
    try {
      userModel.value = await _appPrefs.readUser(Constants.user_key);
    } catch (e) {
      print(e);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: new Text("Nothing found!"),
      //     duration: const Duration(milliseconds: 500)));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadSharedPrefs();
  }

  var currentPage = 0.obs;
  // var totalPage = 0.obs;
  var limitPage = 10.obs;
  var productIndex = 0.obs;
  OrderService _orderService = OrderService();
  var isLoading = true.obs;
  var isLoadingForDate = false.obs;
  var orderList = List<Re>.empty(growable: true).obs;
  var orderListByDate = List<Re>.empty(growable: true).obs;
  var currentOrder = Re().obs;
  var currentOrderIndex = 0.obs;
  var dispactchUpdatedWeightSingleProduct = 0.0.obs;
  var orderStatusValue = 4.obs;
  bool isOderCanEdit(DateTime dateTime) {
    print(dateTime.add(Duration(days: 1)));
    print(DateTime.now());
    if (DateTime.now().isBefore(dateTime.add(Duration(days: 1)))) {
      return true;
    } else
      return false;
  }

//3 means list all element in order list
  Future<void> pageFetch() async {
    _userModel = await _appPrefs.readUser(Constants.user_key);

    print("Current Page ${currentPage.value}");

    try {
      // if (orderStatusValue.value == 3) {
      //   getAllDeliveredOrders();
      // }
      if (currentPage.value != 0) {
        isFetching.value = true;
        await _orderService
            .fetchByPage(currentPage.value, limitPage.value, _userModel.data.id,
                _userModel.data.role)
            .then((value) {
          orderList.addAll(value.output.orderModel);
          orderList.toSet().toList();
          if (value.output.next != null) {
            print("NEXT PAGE : ${value.output.next.page}");
            currentPage.value = value.output.next.page;
            print("Changing page :${currentPage.value}");

            print(currentPage.value);
            //print(totalPage.value);
          } else
            currentPage.value = 0;
        }).whenComplete(() => isFetching.value = false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getOrderByDate(String date) async {
    try {
      isLoadingForDate(true);
      orderListByDate.clear();
      orderList.clear();
      _userModel = await _appPrefs.readUser(Constants.user_key);
      final OrderDateResponse response = await _orderService.getAllOrderByDate(
          date, _userModel.data.role, _userModel.data.id);
      //  getAllDeliveredOrders();

      orderList.value = response.output;
      // orderList.toSet().toList();

      // if (response.output.next != null) {
      //   currentPage.value = response.output.next.page;
      //   //totalPage.value = response.output.next.totalPages;
      //   // limitPage.value = response.output.next.limit;
      //   //print("TOTAL PAGE :${totalPage.value}");
      // } else {
      //   currentPage.value = 0;
      //   // totalPage.value = 0;
      // }
      isLoadingForDate.value = false;
      isLoading(false);
    } catch (e) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // showCustomDialog(context, 'Error', errorMessage);
      print(e);
      isLoading(false);
    }
  }

  getAllOrders(int page, int limit, status) async {
    orderList.clear();

    _userModel = await _appPrefs.readUser(Constants.user_key);

    print("User From Order ROLE ${_userModel.data.role}");
    try {
      final OrderResponse response = await _orderService.getAllOrders(
          page, 10, _userModel.data.id, _userModel.data.role);
      //  getAllDeliveredOrders();
      orderList.value = response.output.orderModel;
      orderList.toSet().toList();

      if (response.output.next != null) {
        currentPage.value = response.output.next.page;
        //totalPage.value = response.output.next.totalPages;
        // limitPage.value = response.output.next.limit;
        //print("TOTAL PAGE :${totalPage.value}");
      } else {
        currentPage.value = 0;
        // totalPage.value = 0;
      }

      isLoading(false);
    } catch (e) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // showCustomDialog(context, 'Error', errorMessage);
      print(e);
      isLoading(false);
    }
  }

  List<Re> getFilterdOrderList(int status) {
    // Pending - 0 - Red
// Accepted - 1 - Orange
//incomplete -1 - Orange
//complete  -2 - yellow
// Delivered - 3- Green
    if (status == 1) {
      return orderList
          .toList()
          .where((element) => element.orderStatus == 1)
          .toList()
          .toList();
    } else if (status == 3) {
      return orderList
          .toList()
          .where((element) => element.orderStatus == 3)
          .toList()
          .toList();
    } else if (status == 2) {
      return orderList.where((element) => element.orderStatus == 2).toList();
    } else if (status == 0) {
      return orderList
          .toList()
          .where((element) => element.orderStatus == 0)
          .toList()
          .toList();
    } else
      return orderList.toList().toSet().toList();
  }

  var deliveredOrderPage = 1.obs;
  var deliveredOrderList = List<Re>.empty(growable: true);
  Color getOrderStatusColor(int status) {
    if (status == 0) {
      return Color(0xffB42949);
    } else if (status == 1) {
      return Color(0xffE5976E);
    } else if (status == 2) {
      return Color(0xffE5D597);
    } else if (status == 3) {
      return Color(0xff51857C);
    }
    return Colors.black;
  }

  // getAllDeliveredOrders() async {
  //   if (deliveredOrderPage.value != 0) {
  //     final response =
  //         await _orderService.getAllDeliveredOrders(deliveredOrderPage.value);
  //     print("Delivered Orders----------------------------");
  //     print(response.output.orderModel.length);
  //     deliveredOrderList.addAll(response.output.orderModel);
  //     if (response.output.next != null) {
  //       deliveredOrderPage += 1;
  //     } else {
  //       deliveredOrderPage.value = 0;
  //     }
  //   }
  // }

  void addDispatchDetails({
    context,
    String dpDate,
    String recivedby,
    int phone,
    double tw,
    String vehicleNo,
  }) async {
    try {
      final CreateOrderResponse response =
          await _orderService.addDispatchManagerProperties(
              dpDate,
              recivedby,
              phone,
              tw,
              vehicleNo,
              currentOrder.value.products,
              currentOrder.value.id);
      if (response.status == 200) {
        print("Sales edit response $response");
        Get.back();
      }
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(context, 'Error', errorMessage, () {
        Get.back();
      });
    }
  }

  // getReadymadeOrders() async {
  //   try {
  //     final OrderResponse response = await _orderService.getReadymadeOrders();
  //     // if (response.orderList == 200) {
  //     //   print("Order Created: $response");
  //     // }
  //     _readyMadeOrders = response;
  //     setLoading(false);
  //   } catch (e) {
  //     // final errorMessage = DioExceptions.fromDioError(e).toString();
  //     // showCustomDialog(context, 'Error', errorMessage);
  //     print(e);
  //     setLoading(false);
  //   }
  // }
}
