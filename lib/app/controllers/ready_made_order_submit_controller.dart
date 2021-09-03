import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/create_order_response.dart';
import 'package:inventory_management/app/data/models/order_model.dart';
import 'package:inventory_management/app/data/services/orders_service.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';

class ReadyMadeOrderSubmitController extends GetxController{
  OrderService _orderService =OrderService();
  var onOrderSubmit=false.obs;

  orderSubmit(OrderModel model,BuildContext context)async{
    onOrderSubmit(true);

    try {
      final CreateOrderResponse response =
          await _orderService.createNewOrder(orderModel: model);
      if (response.status == 200) {
        print("Order Created: $response");
        showCustomDialog(context, 'Order', "Order Submit Successfully", () {
          Get.offAll(HomeScreen());
        });

      }
      onOrderSubmit(false);
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(context, 'Error', errorMessage, () {
        Navigator.of(context).pop();
      });
      onOrderSubmit(false);
    }

  }
}