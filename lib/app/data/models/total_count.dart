// To parse this JSON data, do
//
//     final totalCounts = totalCountsFromJson(jsonString);

import 'dart:convert';

TotalCounts totalCountsFromJson(String str) =>
    TotalCounts.fromJson(json.decode(str));

String totalCountsToJson(TotalCounts data) => json.encode(data.toJson());

class TotalCounts {
  TotalCounts({
    this.status,
    this.msg,
    this.totalsales,
    this.totalclients,
    this.pendingOrder,
  });

  int status;
  String msg;
  List<CountObject> totalsales;
  int totalclients;
  List<CountObject> pendingOrder;

  factory TotalCounts.fromJson(Map<String, dynamic> json) => TotalCounts(
        status: json["status"],
        msg: json["msg"],
        totalsales: List<CountObject>.from(
            json["totalsales"].map((x) => CountObject.fromJson(x))),
        totalclients: json["totalClients"] ?? 0,
        pendingOrder: List<CountObject>.from(
            json["pendingOrder"].map((x) => CountObject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "totalsales": List<dynamic>.from(totalsales.map((x) => x.toJson())),
        "totalClients": totalclients,
        "pendingOrder": List<dynamic>.from(pendingOrder.map((x) => x.toJson())),
      };
}

class CountObject {
  CountObject({
    this.count,
  });

  int count;

  factory CountObject.fromJson(Map<String, dynamic> json) => CountObject(
        count: json["count"] == null ? 0 : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
