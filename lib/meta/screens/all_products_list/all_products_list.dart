import 'package:connectivity/connectivity.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/conectivity_tester.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/controllers/edit_order_by_sales_controller.dart';
import 'package:inventory_management/app/data/models/create_order_response.dart';
import 'package:inventory_management/common/widgets/cart_list_item.dart';
import 'package:inventory_management/meta/screens/create_order_screen/create_order_screen.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/components/product_tile_sales_edit.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';
import 'package:inventory_management/provider/cart_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AllProductsList extends StatelessWidget {
  final DashBoardController _dashBoardController = Get.find();

  final ConnectivityTester _connectivityTester = Get.put(ConnectivityTester());

  @override
  Widget build(BuildContext context) {
    Future<CreateOrderResponse> createNewOrder() async {
      return await Provider.of<CartProvider>(context, listen: false)
          .createNewOrder(context: context);
    }

    return Consumer<CartProvider>(
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: kPrimaryColorDark,
            appBar: appBar(
                title: "Products",
                leadingWidget: BackButton(
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.snackbar(
                            "Hint", "To remove Product swipe left to right",
                            icon: Icon(Icons.info_outline),
                            snackPosition: SnackPosition.BOTTOM);
                      })
                ]),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: Get.size.height,
                  width: Get.size.width,
                ),
                Container(
                  child: model.products == null || model.products.isEmpty
                      ? Container(
                          height: Get.size.height,
                          width: Get.size.width,
                          child: Center(
                            child: Text(
                              "No Products Added",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                              bottom: 80,
                            ),
                            itemCount: model.products.length,
                            itemBuilder: (context, index) {
                              print(int.tryParse(_dashBoardController
                                  .userModel.value.data.role));
                              //   var product = model.products[index];
                              return
                                  //Text(index.toString());
                                  Dismissible(
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        model.products.removeAt(index);
                                      },
                                      key: ValueKey<int>(index),
                                      background: Container(
                                        padding: const EdgeInsets.all(16),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        alignment: Alignment.centerRight,
                                        color: Colors.red,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: CartItemTile(
                                        orderId: model.currentOrder.id,
                                        index: index,
                                        role: int.tryParse(_dashBoardController
                                            .userModel.value.data.role),
                                        product:
                                            model.currentOrder.products[index],
                                        isEditable: false,
                                        isFromAllProduct: true,
                                      ));
                            },
                          ),
                        ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: model.products.isEmpty
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                            label: Text("Order",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            backgroundColor: kPrimaryColorDark,
                            onPressed: () {
                              createNewOrder().then((value) {
                                if (value.status == 200) {
                                  showFlash(
                                      context: context,
                                      duration: Duration(seconds: 2),
                                      builder: (context, controller) {
                                        return Flash.dialog(
                                          controller: controller,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          backgroundColor: Colors.blue,
                                          alignment: Alignment.bottomCenter,
                                          margin: const EdgeInsets.only(
                                              bottom: 120),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Order Placed',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                  model.orderModel = null;
                                  model.products = [];
                                  showCustomDialog(context, "Success",
                                      "Order Placed successfully", () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                        // duration: Duration(milliseconds: 500),
                                        child: HomeScreen(),
                                        type: PageTransitionType.leftToRight,
                                      ),
                                      (r) => false,
                                    );
                                  });
                                }
                              });
                            }),
                        model.isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
