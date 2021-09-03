import 'dart:convert';

ProductionInchargeAssignModel productionInchargeAssignModelFromJson(
        String str) =>
    ProductionInchargeAssignModel.fromJson(json.decode(str));

String productionInchargeAssignModelToJson(
        ProductionInchargeAssignModel data) =>
    json.encode(data.toJson());

class ProductionInchargeAssignModel {
  ProductionInchargeAssignModel({
    this.productionincharge,
    this.assignDate,
    this.completionDate,
    this.pInId,
    this.phNote,
  });

  String productionincharge;
  String assignDate;
  String completionDate;
  String pInId;
  String phNote;

  factory ProductionInchargeAssignModel.fromJson(Map<String, dynamic> json) =>
      ProductionInchargeAssignModel(
        productionincharge: json["productionincharge"],
        assignDate: json["assignDate"],
        completionDate: json["completionDate"],
        pInId: json["pIn_id"],
        phNote: json["phNote"],
      );

  Map<String, dynamic> toJson() => {
        "productionincharge": productionincharge,
        "assignDate": assignDate,
        "completionDate": completionDate,
        "pIn_id": pInId,
        "phNote": phNote,
      };
}
