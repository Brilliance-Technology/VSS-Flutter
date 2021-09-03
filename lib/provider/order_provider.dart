// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'package:inventory_management/app/data/models/order_response.dart';
// import 'package:inventory_management/app/data/services/orders_service.dart';

// class OrderProvider extends ChangeNotifier {
//   OrderService _orderService = OrderService();

//   bool isLoading = false;

//   void setLoading(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }

//   OrderResponse _orderResponse;
//   OrderResponse _readyMadeOrders;
//   StreamController<List<Re>> streamController = StreamController();
// //  Stream< List<Re> >get ordersList => _orderResponse.res;
// //  Stream< List<Re>> get readymadeOrdersList => _readyMadeOrders.res;

//   OrderProvider() {
//     getAllOrders();
//     // getReadymadeOrders();
//   }

//   // Future<OrderResponse> getAllOrders() async {
//   //   // setLoading(true);
//   //   try {
//   //     final OrderResponse response = await _orderService.getAllOrders();
//   //     // if (response.orderList == 200) {
//   //     //   print("Order Created: $response");
//   //     // }
//   //     _orderResponse = response;
//   //     // return response;
//   //     // setLoading(false);

//   //     notifyListeners();
//   //     return response;
//   //   } catch (e) {
//   //     // final errorMessage = DioExceptions.fromDioError(e).toString();
//   //     // showCustomDialog(context, 'Error', errorMessage);
//   //     print(e);
//   //     notifyListeners();
//   //     // setLoading(false);
//   //     // return null;
//   //   }
//   // }

//   Future<void> getAllOrders() async {
//     setLoading(true);
//     try {
//       final OrderResponse response = await _orderService.getAllOrders();
//       // if (response.orderList == 200) {
//       //   print("Order Created: $response");
//       // }
//       _orderResponse = response;
//       setLoading(false);
//     } catch (e) {
//       // final errorMessage = DioExceptions.fromDioError(e).toString();
//       // showCustomDialog(context, 'Error', errorMessage);
//       print(e);
//       setLoading(false);
//     }
//   }

//   // Future<void> getReadymadeOrders() async {
//   //   setLoading(true);
//   //   try {
//   //     final OrderResponse response = await _orderService.getReadymadeOrders();
//   //     // if (response.orderList == 200) {
//   //     //   print("Order Created: $response");
//   //     // }
//   //     _readyMadeOrders = response;
//   //     setLoading(false);
//   //   } catch (e) {
//   //     // final errorMessage = DioExceptions.fromDioError(e).toString();
//   //     // showCustomDialog(context, 'Error', errorMessage);
//   //     print(e);
//   //     setLoading(false);
//   //   }
//   // }
// }
