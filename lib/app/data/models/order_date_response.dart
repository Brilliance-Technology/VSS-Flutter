// To parse this JSON data, do
//
//     final orderDateResponse = orderDateResponseFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/app/data/models/product.dart';

OrderDateResponse orderDateResponseFromJson(String str) => OrderDateResponse.fromJson(json.decode(str));

String orderDateResponseToJson(OrderDateResponse data) => json.encode(data.toJson());

class OrderDateResponse {
  OrderDateResponse({
    this.status,
    this.msg,
    this.output,
  });

  int status;
  String msg;
  List<Re> output;

  factory OrderDateResponse.fromJson(Map<String, dynamic> json) => OrderDateResponse(
    status: json["status"],
    msg: json["msg"],
    output: List<Re>.from(json["output"].map((x) => Re.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "output": List<dynamic>.from(output.map((x) => x.toJson())),
  };
}
//
// class Re {
//   Re(
//       {this.id,
//         this.clientName,
//         this.firmName,
//         this.address,
//         this.city,
//         this.phoneNo,
//         this.orderId,
//         this.deliveryDate,
//         this.orderStatus,
//         this.note,
//         this.products,
//         this.processBar,
//         this.productionincharge,
//         this.assignDate,
//         this.completionDate,
//         this.phNote,
//         this.v,
//         this.orderDate,
//         this.salesId,
//         this.salesName,
//         this.isProgressBarOn,
//         this.vehicleNum,
//         this.dpDate,
//         this.dpRecieved,
//         this.dpPhone,
//         this.createdOrderTime,
//         this.dpTotalWeight});
//
//   String id;
//   String clientName;
//   String firmName;
//   String address;
//   String city;
//   int phoneNo;
//   String orderId;
//   String deliveryDate;
//   int orderStatus;
//   String note;
//   List<Product> products = List.empty(growable: true);
//   String processBar;
//   String productionincharge;
//   String assignDate;
//   String completionDate;
//   String phNote;
//   int v;
//   bool isProgressBarOn;
//   String orderDate;
//   String salesId;
//   String salesName;
//
//   String vehicleNum;
//   String dpDate;
//   String dpRecieved;
//   int dpPhone;
//   double dpTotalWeight;
//   DateTime createdOrderTime;
//   static DateFormat formater = DateFormat("dd-mm-yyyy");
//   factory Re.fromJson(Map<String, dynamic> json) => Re(
//       id: json["_id"],
//       clientName: json["clientName"],
//       firmName: json["firmName"],
//       address: json["address"],
//       city: json["city"],
//       orderDate: json["currentDate"].toString(),
//       // == null
//       //? null
//       //: DateFormat('dd-MM-yyyy')
//       //     .format(DateTime.tryParse(json["currentDate"])) ==
//       // null
//       // ? json["currentDate"].toString()
//       // : DateFormat('dd-MM-yyyy')
//       //     .format(DateTime.tryParse(json["currentDate"])),
//
//       //  json["currentDate"]
//       //     .toString()
//       //     .split('T')
//       //     .first
//       //     .split(" ")
//       //     .reversed
//       //     .join(),
//       phoneNo: json["phone_no"],
//       orderId: json["orderId"],
//       deliveryDate: json["deliveryDate"],
//       orderStatus: json["orderstatus"],
//       note: json["note"],
//       products:
//       List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//       processBar: json["process_bar"],
//       productionincharge: json["productionincharge"],
//       assignDate: json["assignDate"],
//       completionDate: json["completionDate"],
//       phNote: json["phNote"],
//       v: json["__v"],
//       salesId: json["sales_id"],
//       isProgressBarOn: false,
//       salesName: json["sales_name"],
//       vehicleNum: json["vehicleNum"] == null ? null : json["vehicleNum"],
//       dpDate: json["dpDate"] == null ? null : json["dpDate"],
//       dpRecieved: json["dpRecieved"] == null ? null : json["dpRecieved"],
//       dpPhone: json["dpPhone"] == null ? null : json["dpPhone"],
//       dpTotalWeight: json["dpTotalWeight"] == null
//           ? null
//           : json["dpTotalWeight"].toDouble(),
//       createdOrderTime: json['createdAt'] == null
//           ? null
//           : DateTime.parse(json['createdAt'] as String));
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "clientName": clientName,
//     "firmName": firmName,
//     "address": address,
//     "city": city,
//     "phone_no": phoneNo,
//     "currentDate": orderDate,
//     "orderId": orderId,
//     "deliveryDate": deliveryDate,
//     "orderstatus": orderStatus,
//     "note": note,
//     "products": List<dynamic>.from(products.map((x) => x.toJson())),
//     "process_bar": processBar,
//     "productionincharge": productionincharge,
//     "assignDate": assignDate,
//     "completionDate": completionDate,
//     "phNote": phNote,
//     "__v": v,
//     "sales_id": salesId,
//     "sales_name": salesName,
//     "pIn_id": "null",
//     "vehicleNum": vehicleNum,
//     "dpDate": dpDate,
//     "dpRecieved": dpRecieved,
//     "dpPhone": dpPhone,
//     "dpTotalWeight": dpTotalWeight
//   };
// }
// class Product {
//   Product({
//     this.id,
//     this.isOrderReady,
//     this.selectProduct,
//     this.productId,
//     this.company,
//     this.grade,
//     this.topcolor,
//     this.coatingnum,
//     this.temper,
//     this.guardfilm,
//     this.thickness,
//     this.width,
//     this.length,
//     this.pcs,
//     this.weight,
//     this.rate,
//     this.gst,
//     this.pInId,
//     this.productionincharge,
//     this.assignDate,
//     this.completionDate,
//     this.phNote,
//     this.batchList,
//   });
//
//   String id;
//   bool isOrderReady;
//   String selectProduct;
//   String productId;
//   String company;
//   String grade;
//   String topcolor;
//   int coatingnum;
//   String temper;
//   String guardfilm;
//   double thickness;
//   double width;
//   double length;
//   int pcs;
//   double weight;
//   int rate;
//   int gst;
//   String pInId;
//   String productionincharge;
//   String assignDate;
//   String completionDate;
//   String phNote;
//   List<BatchList> batchList;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["_id"],
//     isOrderReady: json["isOrderReady"],
//     selectProduct: json["select_product"],
//     productId: json["productId"],
//     company: json["company"],
//     grade: json["grade"],
//     topcolor: json["topcolor"],
//     coatingnum: json["coatingnum"],
//     temper: json["temper"],
//     guardfilm: json["guardfilm"],
//     thickness: json["thickness"].toDouble(),
//     width: json["width"].toDouble(),
//     length: json["length"].toDouble(),
//     pcs: json["pcs"],
//     weight: json["weight"].toDouble(),
//     rate: json["rate"],
//     gst: json["gst"],
//     pInId: json["pIn_id"],
//     productionincharge: json["productionincharge"],
//     assignDate: json["assignDate"],
//     completionDate: json["completionDate"],
//     phNote: json["phNote"],
//     batchList: List<BatchList>.from(json["batch_list"].map((x) => BatchList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "isOrderReady": isOrderReady,
//     "select_product": selectProduct,
//     "productId": productId,
//     "company": company,
//     "grade": grade,
//     "topcolor": topcolor,
//     "coatingnum": coatingnum,
//     "temper": temper,
//     "guardfilm": guardfilm,
//     "thickness": thickness,
//     "width": width,
//     "length": length,
//     "pcs": pcs,
//     "weight": weight,
//     "rate": rate,
//     "gst": gst,
//     "pIn_id": pInId,
//     "productionincharge": productionincharge,
//     "assignDate": assignDate,
//     "completionDate": completionDate,
//     "phNote": phNote,
//     "batch_list": List<dynamic>.from(batchList.map((x) => x.toJson())),
//   };
// }
//
// class BatchList {
//   BatchList({
//     this.id,
//     this.batchNo,
//     this.batchId,
//   });
//
//   String id;
//   String batchNo;
//   String batchId;
//
//   factory BatchList.fromJson(Map<String, dynamic> json) => BatchList(
//     id: json["_id"],
//     batchNo: json["batch_no"],
//     batchId: json["batch_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "batch_no": batchNo,
//     "batch_id": batchId,
//   };
// }
