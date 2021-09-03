// To parse this JSON data, do
//
//     final pieChartModel = pieChartModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final pieChartModel = pieChartModelFromJson(jsonString);

import 'dart:convert';

PieChartModel pieChartModelFromJson(String str) =>
    PieChartModel.fromJson(json.decode(str));

String pieChartModelToJson(PieChartModel data) => json.encode(data.toJson());

class PieChartModel {
  PieChartModel({
    this.status,
    this.msg,
    this.soldProduct,
    this.availableProduct,
  });

  int status;
  String msg;
  List<PieProduct> soldProduct;
  List<PieProduct> availableProduct;

  factory PieChartModel.fromJson(Map<String, dynamic> json) => PieChartModel(
        status: json["status"],
        msg: json["msg"],
        soldProduct: List<PieProduct>.from(
            json["soldProduct"].map((x) => PieProduct.fromJson(x))),
        availableProduct: List<PieProduct>.from(
            json["availableProduct"].map((x) => PieProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "soldProduct": List<dynamic>.from(soldProduct.map((x) => x.toJson())),
        "availableProduct":
            List<dynamic>.from(availableProduct.map((x) => x.toJson())),
      };
}

class PieProduct {
  PieProduct({
    this.id,
    this.count,
  });

  String id;
  int count;

  factory PieProduct.fromJson(Map<String, dynamic> json) => PieProduct(
        id: json["_id"] == null ? null : json["_id"].toString(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id.toString(),
        "count": count,
      };
}

// import 'dart:convert';

// PieChartModel pieChartModelFromJson(String str) =>
//     PieChartModel.fromJson(json.decode(str));

// String pieChartModelToJson(PieChartModel data) => json.encode(data.toJson());

// class PieChartModel {
//   PieChartModel({
//     this.status,
//     this.msg,
//     this.soldProduct,
//     this.availableProduct,
//   });

//   int status;
//   String msg;
//   List<SoldProductPieChart> soldProduct;
//   List<AvailableProductPieChart> availableProduct;

//   factory PieChartModel.fromJson(Map<String, dynamic> json) => PieChartModel(
//         status: json["status"],
//         msg: json["msg"],
//         soldProduct: List<SoldProductPieChart>.from(
//             json["soldProduct"].map((x) => SoldProductPieChart.fromJson(x))),
//         availableProduct: List<AvailableProductPieChart>.from(
//             json["availableProduct"]
//                 .map((x) => AvailableProductPieChart.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "msg": msg,
//         "soldProduct": List<dynamic>.from(soldProduct.map((x) => x.toJson())),
//         "availableProduct":
//             List<dynamic>.from(availableProduct.map((x) => x.toJson())),
//       };
// }

// class AvailableProductPieChart {
//   AvailableProductPieChart({
//     this.id,
//     this.count,
//   });

//   String id;
//   int count;

//   factory AvailableProductPieChart.fromJson(Map<String, dynamic> json) =>
//       AvailableProductPieChart(
//         id: json["_id"] == null ? null : json["_id"].toString(),
//         count: json["count"] == null ? null : json["count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "count": count,
//       };
// }

// class SoldProductPieChart {
//   SoldProductPieChart({
//     // this.week,
//     // this.xAxisLabel,
//     // this.year,
//     this.count,
//     this.id,
//   });
//   String id;
//   // int week;
//   // String xAxisLabel;
//   // int year;
//   int count;

//   factory SoldProductPieChart.fromJson(Map<String, dynamic> json) =>
//       SoldProductPieChart(
//         // week: json["week"] == null ? null : json["week"],
//         // xAxisLabel: json["xAxisLabel"].toString(),
//         // year: json["year"] == null ? null : json["year"],
//         id: json["_id"] == null ? null : json["_id"].toString(),
//         count: json["count"] == null ? null : json["count"],
//       );

//   Map<String, dynamic> toJson() => {
//         // "week": week,
//         // "xAxisLabel": xAxisLabel,
//         // "year": year,
//         "_id": id,
//         "count": count,
//       };
// }
