// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

ReadyMadeResponse userFromJson(String str) =>
    ReadyMadeResponse.readMadeModelfromJson(json.decode(str));

String userToJson(ReadyMadeResponse data) =>
    json.encode(data.readMadeMtoJson());

class ReadyMadeResponse {
  ReadyMadeResponse({
    this.status,
    this.msg,
    this.res,
  });

  int status;
  String msg;
  List<ReadyMade> res;

  factory ReadyMadeResponse.readMadeModelfromJson(Map<String, dynamic> json) =>
      ReadyMadeResponse(
        status: json["status"],
        msg: json["msg"],
        res:
            List<ReadyMade>.from(json["res"].map((x) => ReadyMade.fromJson(x))),
      );

  Map<String, dynamic> readMadeMtoJson() => {
        "status": status,
        "msg": msg,
        "res": List<dynamic>.from(res.map((x) => x.toJson())),
      };
}

class ReadyMade {
  ReadyMade({
    this.id,
    this.company,
    this.grade,
    this.topcolor,
    this.coating,
    this.temper,
    this.guardFilm,
    this.productImage,
    this.width,
    this.length,
    this.thickness,
    this.v,
    // this.productId,
    this.selectProduct,
    this.readyProduction,
    this.note,
    this.pcs,
    this.weight,
  });

  String id;

  String company;
  String grade;
  String topcolor;
  int coating;
  String temper;
  String guardFilm;
  String productImage;
  double width;
  double length;
  double thickness;
  int v;
  int pcs;
  // String productId;
  String selectProduct;
  String readyProduction;
  String note;
  double weight;

  factory ReadyMade.fromJson(Map<String, dynamic> json) => ReadyMade(
        id: json["_id"],
        company: json["company"],
        grade: json["grade"],
        topcolor: json["topcolor"],
        coating: json["coating_num"] == null ? null : json["coating"],
        temper: json["temper"],
        guardFilm: json["guardfilm"] == null ? null : json["guard_film"],
        productImage:
            json["product_image"] == null ? null : json["product_image"],
        width: json["width"] == null ? null : json["width"].toDouble(),
        length: json["length"] == null ? null : json["length"].toDouble(),
        thickness:
            json["thickness"] == null ? null : json["thickness"].toDouble(),
        v: json["__v"],
        //  productId: json["productId"] == null ? null : json["productId"],
        selectProduct:
            json["select_product"] == null ? null : json["select_product"],
        readyProduction:
            json["ready_production"] == null ? null : json["ready_production"],
        note: json["note"] == null ? null : json["note"],

        pcs: json["pcs"] == null ? null : json["pcs"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "select_product": selectProduct == null ? null : selectProduct,

        "company": company,
        "grade": grade,
        "topcolor": topcolor,
        "coating_num": coating == null ? null : coating,
        "temper": temper,
        "guard_film": guardFilm == null ? null : guardFilm,
        "product_image": productImage == null ? null : productImage,

        "width": width,
        "length": length,
        "thickness": thickness == null ? null : thickness.toDouble(),
        //  "productId": productId == null ? null : productId,
        "pcs": pcs == null ? null : pcs,
        "weight": weight == null ? null : weight,
        "ready_production": readyProduction,
        "note": note,
        "__v": v,
      };
}
