import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/app/constants/endpoints.dart';
import 'package:inventory_management/app/data/models/create_order_response.dart';
import 'package:inventory_management/app/data/models/order_date_response.dart';
import 'package:inventory_management/app/data/models/order_model.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/app/data/models/ready_made_model.dart';
import '../dio_client.dart';

class OrderService {
  DioClient _dioClient = DioClient();

  Future<CreateOrderResponse> createNewOrder(
      {@required OrderModel orderModel}) async {
    try {
      print(orderModelToJson(orderModel));
      final response = await _dioClient.post("${Endpoints.createOrder}",
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          data: orderModelToJson(orderModel));

      return CreateOrderResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<CreateOrderResponse> editSales({Re order}) async {
    try {
      dynamic data = order.toJson();
      print(data);
      final response = await _dioClient.put(
          "${Endpoints.editSales}/${order.id}",
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          data: data);
      print(response);
      return CreateOrderResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<CreateOrderResponse> addDispatchManagerProperties(
      String dpDate,
      String recivedBy,
      int phone,
      double tw,
      String vehicleNo,
      List<Product> updatedProducts,
      String orderId) async {
//recivedBy,driverNumber,totalweight,productList(updatedWeight),vechileNo;
    try {
      dynamic data = {
        // "orderstatus": 3,
        "dpDate": dpDate,
        "dpRecieved": recivedBy,
        "dpPhone": phone,
        "dpTotalWeight": tw,
        "vehicleNum": vehicleNo,
        "products": List<dynamic>.from(updatedProducts.map((x) => x.toJson())),
      };
      final response = await _dioClient.put("${Endpoints.editSales}/$orderId",
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          data: data);
      print(response);
      return CreateOrderResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<CreateOrderResponse> editProductionHeadDetail({
    @required String id,
    @required String productionincharge,
    @required String assignDate,
    @required String completionDate,
    @required String phNote,
    @required int processBar,
  }) async {
    try {
      dynamic data = {
        // "orderstatus": 2,
        "productionincharge": productionincharge,
        "assignDate": assignDate,
        "completionDate": completionDate,
        "phNote": phNote,
        "processBar": processBar,
      };
      print(data);
      final response = await _dioClient.put("${Endpoints.editSales}/$id",
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          data: data);
      print(response);
      return CreateOrderResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  // Future<OrderResponse> getAllDeliveredOrders(int page) async {
  //   String url = "/BillingManagement/all2/?page=$page&limit=10&orderstatus=3";
  //   Response response = await _dioClient.get(
  //     url,
  //     options: Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
  //   );

  //   return OrderResponse.fromJson(response.data);
  // }
  Future<OrderDateResponse> getAllOrderByDate(
      String date, String role, String userId) async {
    //http://13.126.107.114/api/v1/BillingManagement/all_with_Date?currentDate=2021-06-11
    String url;
    if (role == "1") {
      url =
          "/BillingManagement/all_with_Date?sales_id=$userId&currentDate=$date";
      print("User Role$role");
    } else {
      if (role == "2") {
        print("User Role$role");
        url = "/BillingManagement/all_with_Date?currentDate=$date";
      } else if (role == '3') {
        print("User Role$role");
        url = "/BillingManagement/all3_with_date";
      } else if (role == "4") {
        url =
            "/BillingManagement/Dispatch_with_Date?orderstatus=2&currentDate=$date";
      } else {
        print("User Role$role");
        url = "/BillingManagement/all_with_Date?currentDate=$date";
      }
    }
    if (role == "3") {
      print(userId + date);
      final response = await _dioClient.post(
        Endpoints.baseUrl + url,
        data: {"pIn_id": userId, "currentDate": date},
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Data By Date calling by incharge");
      print(response);

      return OrderDateResponse.fromJson(response);
    } else {
      Response response = await _dioClient.get(
        url,
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Data By Date");
      print(response.data);

      return OrderDateResponse.fromJson(response.data);
    }
  }

  Future<OrderResponse> getAllOrders(
      int page, int limit, String userID, String role) async {
    String url;
    switch (role) {
      case "1":
        url =
            "/BillingManagement/all2/?page=$page&limit=$limit&sales_id=$userID"; //"/BillingManagement/all3/?page=$page&limit=$limit&sales_id=$userID";
        break;
      case "2":
        url = "/BillingManagement/all/?page=$page&limit=$limit";
        break;
      case "3":
        url =
            "/BillingManagement/all3?page=$page&limit=$limit"; //"/BillingManagement/all3/?page=$page&limit=$limit";
        break;
    }
    print(userID);
    print(url);
    try {
      if (role == "2") {
        Response response = await _dioClient.get(
          url,
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
        );

        return OrderResponse.fromJson(response.data);
      } else if (role == "4") {
        Response response = await _dioClient.get(
          //   http://13.126.107.114/api/v1/BillingManagement/all2/?page=1&limit=10&ost=2
          "/BillingManagement/all2/?page=$page&limit=$limit&orderstatus=2",

          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
        );
        OrderResponse orderResponse = OrderResponse.fromJson(response.data);
        if (response != null) {
          await _dioClient
              .get(
            //   http://13.126.107.114/api/v1/BillingManagement/all2/?page=1&limit=10&ost=2
            "/BillingManagement/all2/?page=$page&limit=$limit&orderstatus=3",

            options:
                Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          )
              .then((value) {
            if (value != null) {
              orderResponse.output.orderModel
                  .addAll(OrderResponse.fromJson(value.data).output.orderModel);
            }
          });
        }

        return orderResponse;
      } else {
        if (role == "3") {
          final response = await _dioClient.post(
            url,
            data: {"pIn_id": "$userID"},
            options:
                Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          );
          return OrderResponse.fromJson(response);
        } else {
          Response response = await _dioClient.get(
            url,
            options:
                Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          );
          return OrderResponse.fromJson(response.data);
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<OrderResponse> fetchByPage(
      int page, int limit, String userID, String role) async {
    print("Role $role");
    String url;
    switch (role) {
      case "1":
        url =
            "/BillingManagement/all2/?page=$page&limit=$limit&sales_id=$userID"; //"/BillingManagement/all3/?page=$page&limit=$limit&sales_id=$userID";
        break;
      case "2":
        url = "/BillingManagement/all/?page=$page&limit=$limit";
        break;
      case "3":
        url =
            "/BillingManagement/all3?page=$page&limit=$limit"; //"/BillingManagement/all3/?page=$page&limit=$limit";
        break;
      case "4":
        //   http://13.126.107.114/api/v1/BillingManagement/all2/?page=1&limit=10&ost=2
        url = "/BillingManagement/all2/?page=$page&limit=$limit&orderstatus=2";
        break;
    }
    print(userID);
    print(url);
    try {
      if (role == "2" || role == "4") {
        Response response = await _dioClient.get(
          url,
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
        );
        if (response != null) {
          print("response");
          print(response.data);
          return OrderResponse.fromJson(response.data);
        }
        return null;
      } else {
        if (role == "3") {
          print(userID);
          final response = await _dioClient.post(
            url,
            data: {"pIn_id": "$userID"},
            options:
                Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          );
          if (response != null) {
            return OrderResponse.fromJson(response);
          }
          return null;
        } else {
          Response response = await _dioClient.get(
            url,
            options:
                Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
          );
          if (response != null) {
            return OrderResponse.fromJson(response.data);
          }
          return null;
        }
      }
    } catch (e) {
      throw e;
    }
    // final response = await _dioClient.post(
    //       role == "3"
    //           ? "/BillingManagement/all3/?page=$page&limit=$limit"
    //           : "/BillingManagement/all2?page=$page&limit=$limit",
    //       data: {"asid": userID},
    //       options:
    //           Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
    //     ) ??
    //     null;
    //
    //   return null;
    // } catch (e) {
    //   throw e;
    // }
  }

  Future<ReadyMadeResponse> getReadymadeOrders() async {
    try {
      Response response = await _dioClient.get(
        "/salesreadymade",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      return ReadyMadeResponse.readMadeModelfromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
