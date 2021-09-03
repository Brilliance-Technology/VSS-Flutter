// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:inventory_management/app/data/models/product.dart';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class Next {
  Next({
    this.page,
    this.limit,
    this.totalPages,
  });

  int page;
  int limit;
  int totalPages;

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        page: json["page"],
        limit: json["limit"],
        totalPages: json["total_doc"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total_doc": totalPages,
      };
}

class Output {
  Output({
    this.next,
    this.previous,
    this.orderModel,
  });

  Next next;
  Next previous;
  List<Re> orderModel;

  factory Output.fromJson(Map<String, dynamic> json) => Output(
        next: json["next"] == null ? null : Next.fromJson(json["next"]),
        previous:
            json["previous"] == null ? null : Next.fromJson(json["previous"]),
        orderModel: List<Re>.from(json["results"].map((x) => Re.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next": next.toJson(),
        "previous": previous.toJson(),
        "results": List<dynamic>.from(orderModel.map((x) => x.toJson())),
      };
}

class OrderResponse {
  OrderResponse({
    this.status,
    this.msg,
    this.output,
  });

  int status;
  String msg;

  Output output;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        status: json["status"],
        msg: json["msg"],
        output: Output.fromJson(json["output"].cast<String, dynamic>()),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "res": output.toJson(),
      };
}

class Re {
  Re(
      {this.id,
      this.clientName,
      this.firmName,
      this.address,
      this.city,
      this.phoneNo,
      this.orderId,
      this.deliveryDate,
      this.orderStatus,
      this.note,
      this.products,
      this.processBar,
      this.productionincharge,
      this.assignDate,
      this.completionDate,
      this.phNote,
      this.v,
      this.orderDate,
      this.salesId,
      this.salesName,
      this.isProgressBarOn,
      this.vehicleNum,
      this.dpDate,
      this.dpRecieved,
      this.dpPhone,
      this.createdOrderTime,
      this.dpTotalWeight});

  String id;
  String clientName;
  String firmName;
  String address;
  String city;
  int phoneNo;
  String orderId;
  String deliveryDate;
  int orderStatus;
  String note;
  List<Product> products = List.empty(growable: true);
  String processBar;
  String productionincharge;
  String assignDate;
  String completionDate;
  String phNote;
  int v;
  bool isProgressBarOn;
  String orderDate;
  String salesId;
  String salesName;

  String vehicleNum;
  String dpDate;
  String dpRecieved;
  int dpPhone;
  double dpTotalWeight;
  DateTime createdOrderTime;
  static DateFormat formater = DateFormat("dd-mm-yyyy");
  factory Re.fromJson(Map<String, dynamic> json) => Re(
      id: json["_id"],
      clientName: json["clientName"],
      firmName: json["firmName"],
      address: json["address"],
      city: json["city"],
      orderDate: json["currentDate"] == null
          ? ""
          : DateFormat('dd-MM-yyyy')
                      .format(DateTime.tryParse(json["currentDate"])) ==
                  null
              ? json["currentDate"].toString()
              : DateFormat('dd-MM-yyyy')
                  .format(DateTime.tryParse(json["currentDate"])),

      //  json["currentDate"]
      //     .toString()
      //     .split('T')
      //     .first
      //     .split(" ")
      //     .reversed
      //     .join(),
      phoneNo: json["phone_no"],
      orderId: json["orderId"],
      deliveryDate: json["deliveryDate"],
      orderStatus: json["orderstatus"],
      note: json["note"],
      products:
          List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      processBar: json["process_bar"],
      productionincharge: json["productionincharge"],
      assignDate: json["assignDate"],
      completionDate: json["completionDate"],
      phNote: json["phNote"],
      v: json["__v"],
      salesId: json["sales_id"],
      isProgressBarOn: false,
      salesName: json["sales_name"],
      vehicleNum: json["vehicleNum"] == null ? null : json["vehicleNum"],
      dpDate: json["dpDate"] == null ? null : json["dpDate"],
      dpRecieved: json["dpRecieved"] == null ? null : json["dpRecieved"],
      dpPhone: json["dpPhone"] == null ? null : json["dpPhone"],
      dpTotalWeight: json["dpTotalWeight"] == null
          ? null
          : json["dpTotalWeight"].toDouble(),
      createdOrderTime: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "updateType": "SalesManager",
        "clientName": clientName,
        "firmName": firmName,
        "address": address,
        "city": city,
        "phone_no": phoneNo,
        "currentDate": orderDate,
        "orderId": orderId,
        "deliveryDate": deliveryDate,
        "orderstatus": orderStatus,
        "note": note,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "process_bar": processBar,
        "productionincharge": productionincharge,
        "assignDate": assignDate,
        "completionDate": completionDate,
        "phNote": phNote,
        "__v": v,
        "sales_id": salesId,
        "sales_name": salesName,
        "pIn_id": "null",
        "vehicleNum": vehicleNum,
        "dpDate": dpDate,
        "dpRecieved": dpRecieved,
        "dpPhone": dpPhone,
        "dpTotalWeight": dpTotalWeight
      };
}
