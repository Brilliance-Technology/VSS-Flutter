// To parse this JSON data, do
//
//     final SalesDashboardModel = SalesDashboardModelFromJson(jsonString);

import 'dart:convert';

SalesDashboardModel salesDashboardModelFromJson(String str) => SalesDashboardModel.fromJson(json.decode(str));

String salesDashboardModelToJson(SalesDashboardModel data) => json.encode(data.toJson());

class SalesDashboardModel {
    SalesDashboardModel({
        this.status,
        this.msg,
        this.soldProduct,
        this.availableProduct,
    });

    int status;
    String msg;
    List<SoldProduct> soldProduct;
    List<AvailableProduct> availableProduct;

    factory SalesDashboardModel.fromJson(Map<String, dynamic> json) => SalesDashboardModel(
        status: json["status"],
        msg: json["msg"],
        soldProduct: List<SoldProduct>.from(json["soldProduct"].map((x) => SoldProduct.fromJson(x))),
        availableProduct: List<AvailableProduct>.from(json["availableProduct"].map((x) => AvailableProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "soldProduct": List<dynamic>.from(soldProduct.map((x) => x.toJson())),
        "availableProduct": List<dynamic>.from(availableProduct.map((x) => x.toJson())),
    };
}

class AvailableProduct {
    AvailableProduct({
        this.id,
        this.count,
    });

    dynamic id;
    int count;

    factory AvailableProduct.fromJson(Map<String, dynamic> json) => AvailableProduct(
        id: json["_id"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
    };
}

class SoldProduct {
    SoldProduct({
        this.id,
    });

    IdClass id;

    factory SoldProduct.fromJson(Map<String, dynamic> json) => SoldProduct(
        id: IdClass.fromJson(json["_id"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
    };
}

class IdClass {
    IdClass({
        this.salesId,
        this.salesName,
        this.selectProduct,
        this.count,
    });

    String salesId;
    String salesName;
    String selectProduct;
    int count;

    factory IdClass.fromJson(Map<String, dynamic> json) => IdClass(
        salesId: json["sales_id"],
        salesName: json["sales_name"],
        selectProduct: json["select_product"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "sales_id": salesId,
        "sales_name": salesName,
        "select_product": selectProduct,
        "count": count,
    };
}














// // To parse this JSON data, do
// //
// //     final SalesDahboardModel = SalesDahboardModelFromJson(jsonString);

// import 'dart:convert';

// SalesDahboardModel salesDahboardModelFromJson(String str) => SalesDahboardModel.fromJson(json.decode(str));

// String salesDahboardModelToJson(SalesDahboardModel data) => json.encode(data.toJson());

// class SalesDahboardModel {
//     SalesDahboardModel({
//         this.status,
//         this.msg,
//         this.sales,
//         this.availableProduct,
//         this.soldProduct,
//         this.readyProduct,
//     });

//     int status;
//     String msg;
//     List<Sale> sales;
//     List<AvailableProduct> availableProduct;
//     List<SoldProduct> soldProduct;
//     List<ReadyProduct> readyProduct;

//     factory SalesDahboardModel.fromJson(Map<String, dynamic> json) => SalesDahboardModel(
//         status: json["status"],
//         msg: json["msg"],
//         sales: List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
//         availableProduct: List<AvailableProduct>.from(json["availableProduct"].map((x) => AvailableProduct.fromJson(x))),
//         soldProduct: List<SoldProduct>.from(json["soldProduct"].map((x) => SoldProduct.fromJson(x))),
//         readyProduct: List<ReadyProduct>.from(json["readyProduct"].map((x) => ReadyProduct.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "msg": msg,
//         "sales": List<dynamic>.from(sales.map((x) => x.toJson())),
//         "availableProduct": List<dynamic>.from(availableProduct.map((x) => x.toJson())),
//         "soldProduct": List<dynamic>.from(soldProduct.map((x) => x.toJson())),
//         "readyProduct": List<dynamic>.from(readyProduct.map((x) => x.toJson())),
//     };
// }

// class AvailableProduct {
//     AvailableProduct({
//         this.id,
//         this.count,
//     });

//     AvailableProductId id;
//     int count;

//     factory AvailableProduct.fromJson(Map<String, dynamic> json) => AvailableProduct(
//         id: AvailableProductId.fromJson(json["_id"]),
//         count: json["count"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id.toJson(),
//         "count": count,
//     };
// }

// class AvailableProductId {
//     AvailableProductId({
//         this.product,
//     });

//     dynamic product;

//     factory AvailableProductId.fromJson(Map<String, dynamic> json) => AvailableProductId(
//         product: json["product"],
//     );

//     Map<String, dynamic> toJson() => {
//         "product": product,
//     };
// }

// class ReadyProduct {
//     ReadyProduct({
//         this.id,
//         this.count,
//     });

//     ReadyProductId id;
//     int count;

//     factory ReadyProduct.fromJson(Map<String, dynamic> json) => ReadyProduct(
//         id: ReadyProductId.fromJson(json["_id"]),
//         count: json["count"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id.toJson(),
//         "count": count,
//     };
// }

// class ReadyProductId {
//     ReadyProductId({
//         this.selectProduct,
//     });

//     String selectProduct;

//     factory ReadyProductId.fromJson(Map<String, dynamic> json) => ReadyProductId(
//         selectProduct: json["select_product"] == null ? null : json["select_product"],
//     );

//     Map<String, dynamic> toJson() => {
//         "select_product": selectProduct == null ? null : selectProduct,
//     };
// }

// class Sale {
//     Sale({
//         this.id,
//         this.totalSalesRate,
//         this.countSales,
//     });

//     dynamic id;
//     double totalSalesRate;
//     int countSales;

//     factory Sale.fromJson(Map<String, dynamic> json) => Sale(
//         id: json["_id"],
//         totalSalesRate: json["Total Sales rate"].toDouble(),
//         countSales: json["countSales"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "Total Sales rate": totalSalesRate,
//         "countSales": countSales,
//     };
// }

// class SoldProduct {
//     SoldProduct({
//         this.id,
//         this.count,
//     });

//     String id;
//     int count;

//     factory SoldProduct.fromJson(Map<String, dynamic> json) => SoldProduct(
//         id: json["_id"] == null ? null : json["_id"],
//         count: json["count"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id == null ? null : id,
//         "count": count,
//     };
// }
