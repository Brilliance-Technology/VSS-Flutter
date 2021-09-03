import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:inventory_management/app/data/models/product.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel(
      {this.clientName,
      this.id,
     
      this.firmName,
      this.address,
      this.city,
      this.phoneNo,
      this.orderId,
      this.deliveryDate,
      this.orderStatus,
      this.currentDate,
      this.note,
      this.products,
      this.productionincharge,
      this.assignDate,
      this.completionDate,
      this.phNote,
      this.smName,
      this.vehicleNum,
      this.dpDate,
      this.dpRecieved,
      this.dpPhone,
      this.dpTotalWeight,
      this.processBar,
      this.salesId,
      this.salesName});

  String clientName;
  String id;
  String firmName;
  String address;
  String city;
  int phoneNo;
  String orderId;
  String deliveryDate;
  int orderStatus;
  String currentDate;
  String note;
  List<Product> products;
  String productionincharge;
  String assignDate;
  String completionDate;
  String phNote;
  String smName;
  String vehicleNum;
  String dpDate;
  String dpRecieved;
  int dpPhone;
  double dpTotalWeight;
  int processBar;

  @required
  String salesName;
  @required
  String salesId;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      id: json["_id"],
      clientName: json["clientName"],
      firmName: json["firmName"],
      address: json["address"],
      city: json["city"],
      phoneNo: json["phone_no"],
      orderId: json["orderId"],
      deliveryDate: json["deliveryDate"],
      orderStatus: json["orderstatus"],
      currentDate: json["currentDate"],
      note: json["note"],
      
      products:
          List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      productionincharge: json["productionincharge"],
      assignDate: json["assignDate"],
      completionDate: json["completionDate"],
      phNote: json["phNote"],
      smName: json["smName"],
      vehicleNum: json["vehicleNum"],
      dpDate: json["dpDate"],
      dpRecieved: json["dpRecieved"],
      dpPhone: json["dpPhone"],
      dpTotalWeight: json["dpTotalWeight"],
      processBar: json["process_bar"],
      salesId: json["sales_id"],
      salesName: json["sales_name"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "clientName": clientName,
        "firmName": firmName,
       
        "address": address,
        "city": city,
        "phone_no": phoneNo,
        "orderId": orderId,
        "deliveryDate": deliveryDate,
        "currentDate": currentDate,
        "note": note,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "productionincharge": productionincharge,
        "assignDate": assignDate,
        "completionDate": completionDate,
        "phNote": phNote,
        "smName": smName,
        "vehicleNum": vehicleNum,
        "dpDate": dpDate,
        "dpRecieved": dpRecieved,
        "dpPhone": dpPhone,
        "dpTotalWeight": dpTotalWeight,
        "process_bar": processBar,
        "sales_id": salesId,
        "sales_name": salesName,
        "orderstatus": orderStatus
      };
}
