// To parse this JSON data, do
//
//     final BatchFilterModel = BatchFilterModelFromJson(jsonString);

import 'dart:convert';

BatchFilterModel batchFilterModelFromJson(String str) =>
    BatchFilterModel.fromJson(json.decode(str));

String batchFilterModelToJson(BatchFilterModel data) =>
    json.encode(data.toJson());

class BatchFilterModel {
  BatchFilterModel({
    this.status,
    this.msg,
    this.listData,
  });

  int status;
  String msg;
  List<ListBatch> listData;

  factory BatchFilterModel.fromJson(Map<String, dynamic> json) =>
      BatchFilterModel(
        status: json["status"],
        msg: json["msg"],
        listData: List<ListBatch>.from(
            json["list-data"].map((x) => ListBatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "list-data": List<dynamic>.from(listData.map((x) => x.toJson())),
      };
}

class ListBatch {
  ListBatch({
    this.filterBatch,
    this.id,
    this.company,
    this.grade,
    this.topcolor,
    this.temper,
    this.thickness,
    this.width,
    this.length,
    this.pcs,
    this.weight,
    this.product,
    this.batchNumber,
    this.vehicalNo,
    this.vendor,
    this.assignDate,
    this.note,
    this.v,
  });

  List<dynamic> filterBatch;
  bool isSelected = false;
  String id;
  String company;
  String grade;
  String topcolor;
  String temper;
  double thickness;
  double width;
  double length;
  int pcs;
  double weight;
  int product;
  String batchNumber;
  String vehicalNo;
  String vendor;
  String assignDate;
  String note;
  int v;

  factory ListBatch.fromJson(Map<String, dynamic> json) => ListBatch(
        filterBatch: json["filter_batch"] == [] || json["filter_batch"] == null
            ? []
            : List<dynamic>.from(json["filter_batch"].map((x) => x)),
        id: json["_id"],
        company: json["company"],
        grade: json["grade"],
        topcolor: json["topcolor"],
        temper: json["temper"],
        thickness:
            json["thickness"] == null ? null : json["thickness"].toDouble(),
        width: json["width"] == null ? null : json["width"].toDouble(),
        length: json["length"] == null ? null : json["length"].toDouble(),
        pcs: json["pcs"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        product: json["product"],
        batchNumber: json["batch_number"],
        vehicalNo: json["vehical_no"],
        vendor: json["vendor"],
        assignDate: json["assign_date"],
        note: json["note"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "filter_batch": List<dynamic>.from(filterBatch.map((x) => x)),
        "_id": id,
        "company": company,
        "grade": grade,
        "topcolor": topcolor,
        "temper": temper,
        "thickness": thickness,
        "width": width,
        "length": length,
        "pcs": pcs,
        "weight": weight,
        "product": product,
        "batch_number": batchNumber,
        "vehical_no": vehicalNo,
        "vendor": vendor,
        "assign_date": assignDate,
        "note": note,
        "__v": v,
      };
}

class BatchUpdateModel {
  int pcsCut;
  double lengthPerPcsCut;
  double approxWeightPerMM;
  String batchId;
  BatchUpdateModel(
      {this.pcsCut,
      this.lengthPerPcsCut,
      this.approxWeightPerMM,
      this.batchId});
  factory BatchUpdateModel.fromJson(Map<String, dynamic> json) =>
      BatchUpdateModel(
        pcsCut:json["pcs_cut"] == null?null:json["pcs_cut"],
        lengthPerPcsCut:json["pcs_cut"] == null?null:json["pcs_cut"].toDouble(),
        approxWeightPerMM: json["pcs_cut"] == null?null:json["pcs_cut"].toDouble(),
        batchId: json["pcs_cut"] == null?null:json["pcs_cut"].toString()

      );
  Map<String, dynamic> toJson() => {
        "pcs_cut": pcsCut,
        "length_per_pcs_cut": lengthPerPcsCut,
        "approx_weight_per_mm": approxWeightPerMM
      };
}
