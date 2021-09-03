import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/create_order_response.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/app/data/services/orders_service.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';

class EditOrderBySalesController extends GetxController {
  var thickness = 0.0.obs;
  var width = 0.0.obs;
  var selectedLength = 0.0.obs;
  var coating = 0.obs;
  var temper = "".obs;
  var guard = "".obs;
  var selectedOrder = Re(products: List<Product>.empty(growable: true)).obs;
  //var selectedProduct = Product().obs;
  OrderService _orderService = OrderService();

  // updateProductToList(Product product, int index) {
   

  // }

  void editOrderBySales({Re order, BuildContext context}) async {
    try {
      final CreateOrderResponse response =
          await _orderService.editSales(order: order);
      if (response.status == 200) {
        print("Sales edit response $response");
      }
      if (response.status == 200 &&
          response.msg !=
              " Sorry! you can not edit this record after 24 hours.") {
        Get.offAll(HomeScreen());
        Get.snackbar("Order", "Order SuccessFully Updated");
      } else {
        showCustomDialog(context, 'Error',
            "Sorry! you can not edit this record after 24 hours.", () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(context, 'Error', errorMessage, () {
        Navigator.of(context).pop();
      });
    }
  }
}
