// To parse this JSON data, do
//
//     final BarGraphModel = BarGraphModelFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final barGraphModel = barGraphModelFromJson(jsonString);

BarGraphData barGraphModelFromJson(String str) =>
    BarGraphData.fromJson(json.decode(str));

String barGraphModelToJson(BarGraphData data) => json.encode(data.toJson());

class BarGraphData {
  BarGraphData({
    this.status,
    this.msg,
    this.barGraphList,
  });

  int status;
  String msg;
  List<BarGraph> barGraphList;

  factory BarGraphData.fromJson(Map<String, dynamic> json) => BarGraphData(
        status: json["status"],
        msg: json["msg"],
        barGraphList:
            List<BarGraph>.from(json["res"].map((x) => BarGraph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "res": List<dynamic>.from(barGraphList.map((x) => x.toJson())),
      };
}

class BarGraph {
  BarGraph({
    this.id,
    this.weight,
    this.xAxisLabel,
  });

  DateTime id;
  double weight;
  String xAxisLabel;

  factory BarGraph.fromJson(Map<String, dynamic> json) => BarGraph(
        id: DateTime.parse(json["_id"]),
        weight: json["weight"].toDouble(),
        xAxisLabel: json["xAxisLabel"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toIso8601String(),
        "weight": weight,
        "xAxisLabel": xAxisLabel,
      };
}

// BarGraphModel barGraphModelFromJson(String str) => BarGraphModel.fromJson(json.decode(str));

// String barGraphModelToJson(BarGraphModel data) => json.encode(data.toJson());

class BarGraphModel {
  BarGraphModel({
    this.graphList,
  });

  List<GraphList> graphList;

  factory BarGraphModel.fromJson(Map<String, dynamic> json) => BarGraphModel(
        graphList:
            List<GraphList>.from(json["res"].map((x) => GraphList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res": List<dynamic>.from(graphList.map((x) => x.toJson())),
      };
}

class GraphList {
  GraphList({
    this.id,
    this.count,
    this.totalSalesRate,
  });

  String id;
  int count;
  double totalSalesRate;

  factory GraphList.fromJson(Map<String, dynamic> json) => GraphList(
        id: json["_id"],
        count: json["count"],
        totalSalesRate: json["Total Sales rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
        "Total Sales rate": totalSalesRate,
      };
}
