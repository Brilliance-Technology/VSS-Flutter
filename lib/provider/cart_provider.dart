import 'package:flutter/material.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/create_order_response.dart';
import 'package:inventory_management/app/data/models/order_model.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/app/data/services/orders_service.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';

class CartProvider extends ChangeNotifier {
  OrderService _orderService = OrderService();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    products = null;
    super.dispose();
  }

  OrderModel orderModel = OrderModel();

  List<Product> products = List<Product>.empty(growable: true);

  int get productsLength => products.length;

  OrderModel get currentOrder => orderModel;

  // List<CartModel> getData() {
  //   var groupByProduct = groupBy(products, (obj) => obj.selectProduct);
  //   groupByProduct.forEach((product, list) {
  //     print('$product');

  //     CartModel cartModel = CartModel(
  //         productName: product, quantity: list.length, products: list);

  //     cartItems.add(cartModel);
  //     // Group
  //     list.forEach((listItem) {
  //       // List item
  //       print('${list[0].selectProduct}, $listItem');
  //     });
  //   });
  //   return cartItems;
  // }

  double _width = 0;
  double _thickness = 0;
  double _length = 0;

  double get width => _width;
  double get thickness => _thickness;
  double get length => _length;

  setWidth(double width) {
    this._width = width;
  }

  setThickness(double thickness) {
    this._thickness = thickness;
  }

  setLength(double length) {
    this._length = length;
  }

  addProductToCart(Product product, BuildContext context) async {
    products.add(product);
    orderModel.products = products;
    print(orderModelToJson(orderModel));
    notifyListeners();
    // await createNewOrder(context: context);
  }

  addOrder(OrderModel orderModel) {
    this.orderModel = orderModel;
    print(orderModelToJson(orderModel));
    notifyListeners();
  }

  Future<CreateOrderResponse> createNewOrder({BuildContext context}) async {
    setLoading(true);
    CreateOrderResponse response;
    try {
      orderModel.orderStatus = orderModel.products
                  .where((element) => element.isOrderReady == true)
                  .length ==
              orderModel.products.length
          ? 2
          : 0;
      response = await _orderService.createNewOrder(orderModel: orderModel);
      if (response.status == 200) {
        print("Order Created: $response");
      }
      setLoading(false);
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(context, 'Error', errorMessage, () {
        Navigator.of(context).pop();
      });
      setLoading(false);
    }
    return response;
  }

  Future<void> editProductionHeadDetails(
      {BuildContext context,
      id: String,
      productionIncharge: String,
      assignDate: String,
      completionDate: String,
      phNote: String}) async {
    setLoading(true);
    try {
      final CreateOrderResponse response =
          await _orderService.editProductionHeadDetail(
        id: id,
        productionincharge: productionIncharge,
        assignDate: assignDate,
        completionDate: completionDate,
        phNote: phNote,
        processBar: 2,
      );
      if (response.status == 200) {
        print("Production edit Response: $response");
      }
      setLoading(false);
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(context, 'Error', errorMessage, () {
        Navigator.of(context).pop();
      });
      setLoading(false);
    }
  }
}
