import 'package:inventory_management/app/data/models/product.dart';

class CartModel {
  CartModel({this.productName, this.quantity, this.products});

  String productName;
  int quantity;
  List<Product> products;
}
