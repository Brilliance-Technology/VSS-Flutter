class Product {
  Product(
      {this.id,
      this.selectProduct,
      this.productId,
      this.company,
      this.grade,
      this.topcolor,
      this.coatingnum,
      this.temper,
      this.guardfilm,
      this.thickness,
      this.width,
      this.length,
      this.pcs,
      this.weight,
      this.rate,
      this.gst,
      this.batchList,
      this.completionDate,
      this.assignDate,
      this.isOrderReady,
      this.phId,
      this.phNote,
      this.productionIncharge,
      this.isproductionInchargAssigned,
      this.isproductBatchSubmied});

  String id;

  String selectProduct;
  String productId;
  String company;
  String grade;
  String topcolor;
  int coatingnum;
  String temper;
  String guardfilm;
  double thickness;
  double width;
  double length;
  int pcs;
  double weight;
  double rate;
  double gst;
  List<dynamic> batchList;
  String completionDate;
  String assignDate;
  bool isOrderReady;
  String phId;
  String productionIncharge;
  String phNote;
  bool isproductionInchargAssigned;
  bool isproductBatchSubmied;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["_id"],
      selectProduct: json["select_product"],
      productId: json["productId"],
      company: json["company"],
      grade: json["grade"],
      topcolor: json["topcolor"],
      coatingnum: json["coatingnum"],
      temper: json["temper"],
      guardfilm: json["guardfilm"],
      thickness: json["thickness"] == null
          ? 0.0
          : double.tryParse(json["thickness"].toString()),
      width: json["width"] == null
          ? 0.0
          : double.tryParse(json["width"].toString()),
      length: json["length"] == null
          ? 0.0
          : double.parse(json["length"].toString()),
      pcs: json["pcs"],
      weight: json["weight"] == null
          ? 0.0
          : double.tryParse(json["weight"].toString()),
      rate: double.tryParse(json["rate"].toString()),
      gst: json["gst"] == null ? 0 : json["gst"].toDouble(),
      batchList: json["batch_list"],
      completionDate:
          json["completionDate"] == null ? null : json["completionDate"],
      assignDate: json["assignDate"] == null ? null : json["assignDate"],
      isOrderReady: json["isOrderReady"],
      phId: json["pIn_id"] == null ? null : json["pIn_id"],
      productionIncharge: json["productionincharge"] == null
          ? null
          : json["productionincharge"],
      phNote: json["phNote"] == null ? null : json["phNote"],
      isproductionInchargAssigned: false,
      isproductBatchSubmied: false);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "select_product": selectProduct,
        "productId": productId,
        "company": company,
        "grade": grade,
        "topcolor": topcolor,
        "coatingnum": coatingnum,
        "temper": temper,
        "guardfilm": guardfilm,
        "thickness": thickness,
        "width": width,
        "length": length,
        "pcs": pcs,
        "weight": weight,
        "rate": rate,
        "gst": gst,
        "completionDate": completionDate,
        "assignDate": assignDate,
        "isOrderReady": isOrderReady,
        "pIn_id": phId,
        "productionincharge": productionIncharge,
        "phNote": phNote
      };
}
