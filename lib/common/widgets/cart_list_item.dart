import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/cart_item_title_controller.dart';
import 'package:inventory_management/app/controllers/edit_order_by_sales_controller.dart';
import 'package:inventory_management/app/controllers/orders_controller.dart';

import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/common/widgets/dispatch_bottom_sheet.dart';

import 'package:inventory_management/meta/screens/cart_screen/cart_screen.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/products_edit_by_sales.dart';
import 'package:inventory_management/meta/screens/readymade/components/ready_made_text_title.dart';

import 'package:inventory_management/meta/screens/view_order/batch_bottom_sheet_sheet.dart';

import 'package:page_transition/page_transition.dart';

class CartItemTile extends StatefulWidget {
  final index;
  final isEditable;
  final String orderId;
  final int role;
  final isFromAllProduct;

  CartItemTile(
      {Key key,
      @required this.product,
      this.index,
      this.isEditable,
      this.orderId,
      this.role,
      this.isFromAllProduct})
      : super(key: key);

  final Product product;

  @override
  _CartItemTileState createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  final EditOrderBySalesController _editOrderBySalesController =
      Get.put(EditOrderBySalesController());

  final OrderController _orderController = Get.find();

  final CartItemTileController _cartItemTile =
      Get.put(CartItemTileController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          _orderController.productIndex.value = widget.index;
          switch (widget.role) {
            case 1:
              Navigator.push(
                  context,
                  PageTransition(
                    child: CartScreen(
                      orderId: widget.orderId,
                      product: widget.product,
                      role: widget.role,
                    ),
                    type: PageTransitionType.rightToLeft,
                  ));
              //   ProductEditBySales(
              //     product: widget.product,
              //     orderId: widget.orderId.toString(),
              //   ),
              //   type: PageTransitionType.rightToLeft,
              // ));
              break;
            case 3:
              if (widget.product.batchList.isEmpty &&
                  widget.product.isproductBatchSubmied == false) {
                if (widget.product.pcs > 0) {
                  Get.bottomSheet(
                      BatchBottomSheetContent(
                        product: widget.product,
                        orderId: widget.orderId,
                      ),
                      backgroundColor: Colors.white,
                      isDismissible: false);
                } else
                  Get.snackbar("Batch", "This product can not be assigned");
              } else {
                Navigator.push(
                    context,
                    PageTransition(
                      child: CartScreen(
                        orderId: widget.orderId,
                        product: widget.product,
                        role: widget.role,
                      ),
                      type: PageTransitionType.rightToLeft,
                    ));
                Get.snackbar("Batch", "Batch for this product already added");
              }
              break;
            case 4:
              if (_orderController.currentOrder.value.dpRecieved == "null" ||
                  _orderController.currentOrder.value.dpRecieved == null) {
                Get.defaultDialog(
                  cancel: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  confirm: TextButton(
                    onPressed: () {
                      print(_orderController
                          .currentOrder.value.products[widget.index].weight);
                      _orderController.currentOrder.value.products[widget.index]
                              .weight =
                          _orderController
                              .dispactchUpdatedWeightSingleProduct.value;
                      setState(() {});

                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kStatusBarColor,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Update",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  content: DispatchBottomSheet(
                    index: widget.index,
                  ),
                );
              } else
                Navigator.push(
                    context,
                    PageTransition(
                      child: CartScreen(
                        orderId: widget.orderId,
                        product: widget.product,
                        role: widget.role,
                      ),
                      type: PageTransitionType.rightToLeft,
                    ));
              // Get.bottomSheet(
              //   DispatchBottomSheet(
              //     index: index,
              //   ),
              //   backgroundColor: Colors.white,
              // );
              break;
            default:
              Navigator.push(
                  context,
                  PageTransition(
                    child: CartScreen(
                      orderId: widget.orderId,
                      product: widget.product,
                      role: widget.role,
                    ),
                    type: PageTransitionType.rightToLeft,
                  ));
          }
          // if (isEditable == true) {
          //   Navigator.push(
          //       context,
          //       PageTransition(
          //         child: ProductEditBySales(
          //           product: product,
          //           orderId: orderId.toString(),
          //         ),
          //         type: PageTransitionType.rightToLeft,
          //       ));
          // } else if (_cartItemTile.isUserProductionInCharge.value == false) {
          //   Navigator.push(
          //       context,
          //       PageTransition(
          //         child: CartScreen(
          //           orderId: orderId,
          //           product: product,
          //           role: role,
          //         ),
          //         type: PageTransitionType.rightToLeft,
          //       ));
          // } else if (product.batchList.isEmpty) {
          //   _orderController.productIndex = index;
          //   Get.bottomSheet(
          //       BatchBottomSheetContent(
          //         product: product,
          //         orderId: orderId,
          //       ),
          //       backgroundColor: Colors.white,
          //       isDismissible: false);
          // } else{
          //   Get.snackbar("Batch", "Batch for this product already added");}
          // else if (role == 4) {
          //   Get.snackbar("Dispathc Manager", "message");
          // }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          // width: size.width,
          child: Card(
            margin: const EdgeInsets.all(0),
            elevation: 11,
            shadowColor: Colors.black.withOpacity(0.5),
            color: kPrimaryProductTileColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              width: size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(23)),
              // padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width / 20,
                          vertical: size.height / 90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSizedBox1,
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColorTextDark,
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  child: Text(
                                    widget.product.selectProduct.toString() ??
                                        "",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                // SizedBox(
                                //   width: size.width / 20,
                                // ),
                                Text(
                                  "Product Id   -  ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                Expanded(
                                  child: Container(
                                    width: size.width / 3,
                                    child: Text(
                                      "${widget.product.productId}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            width: size.width / 30,
                            height: size.height / 80,
                          ),
                          Card(
                            elevation: 11,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColorLight,
                                  borderRadius: BorderRadius.circular(23)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.width / 50,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: size.width / 20,
                                        ),
                                        ReadyMadeTextTile(
                                            label: "Thickness",
                                            value: widget.product.thickness
                                                .toStringAsFixed(2)),
                                        SizedBox(
                                          width: size.width / 20,
                                        ),
                                        ReadyMadeTextTile(
                                            label: "Width",
                                            value: widget.product.width
                                                    .toStringAsFixed(2) ??
                                                "0"),
                                        // SizedBox(
                                        //   width: size.width / 30,
                                        // ),
                                        SizedBox(
                                          width: size.width / 20,
                                        ),
                                        ReadyMadeTextTile(
                                            label: "Len",
                                            value: widget.product.length
                                                    .toStringAsFixed(2) ??
                                                "0"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ReadyMadeTextTile(
                                          label: "Pcs",
                                          value:
                                              widget.product.pcs.toString() ??
                                                  "0"),
                                      SizedBox(
                                        width: size.width / 20,
                                      ),
                                      widget.isFromAllProduct == true
                                          ? ReadyMadeTextTile(
                                              label: "Weight",
                                              value: widget.product.weight
                                                      .toStringAsFixed(2) ??
                                                  "0")
                                          : Obx(
                                              () => ReadyMadeTextTile(
                                                  label: "Weight",
                                                  value: _orderController
                                                          .currentOrder
                                                          .value
                                                          .products[
                                                              widget.index]
                                                          .weight
                                                          .toStringAsFixed(2) ??
                                                      "0"),
                                            ),
                                      SizedBox(
                                        width: size.width / 20,
                                      ),
                                      widget.product.isOrderReady == true
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: Get.size.height / 45,
                                                ),
                                                Row(
                                                  children: [
                                                    Card(
                                                      elevation: 5,
                                                      shadowColor: Colors.grey
                                                          .withOpacity(0.5),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColorDark,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            height: 10,
                                                            width: 10,
                                                          )),
                                                    ),
                                                    Text("Ready")
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        width: size.width / 20,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width / 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vSizedBox1,
                                  ReadyMadeTextTile(
                                      label: "TopColor",
                                      value:
                                          widget.product.topcolor.toString()),
                                ],
                              ),
                              SizedBox(
                                width: size.width / 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.role == 1 || widget.role == 2
                                      ? vSizedBox1
                                      : SizedBox(),
                                  widget.role == 1 || widget.role == 2
                                      ? ReadyMadeTextTile(
                                          label: "Rate",
                                          value: widget.product.rate.toString())
                                      : SizedBox()
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
