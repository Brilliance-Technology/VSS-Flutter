import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ProductTileSalesEdit extends StatelessWidget {
  final index;
  final isEditable;

  final int role;

  ProductTileSalesEdit({
    Key key,
    this.index,
    this.isEditable,
    this.role,
  }) : super(key: key);

  final EditOrderBySalesController _editOrderBySalesController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (isEditable == true) {
          Get.to(
              () => Obx(
                    () => ProductEditBySales(
                      index: index,
                      product: _editOrderBySalesController
                          .selectedOrder.value.products[index],
                      orderId: _editOrderBySalesController
                          .selectedOrder.value.id
                          .toString(),
                    ),
                  ),
              transition: Transition.rightToLeft);
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: size.width / 15, vertical: size.width / 50),
        color: Color(0xffECF0F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: Get.width,

          // padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width / 80,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    vSizedBox1,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Obx(
                            () => Text(
                              _editOrderBySalesController.selectedOrder.value
                                  .products[index].selectProduct
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width / 30,
                        ),
                        Container(
                          width: size.width / 2,
                          child: Text(
                            "Product No.  : ${_editOrderBySalesController.selectedOrder.value.products[index].productId}",
                            style: TextStyle(color: kPrimaryColorDark),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width / 30,
                    ),
                    Card(
                      elevation: 3,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23)),
                      child: Container(
                        //alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / 30,
                            vertical: size.width / 80),
                        decoration: BoxDecoration(
                            color: kPrimaryColorLight,
                            borderRadius: BorderRadius.circular(23)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Obx(
                                  () => ReadyMadeTextTile(
                                      label: "Thickness",
                                      value: _editOrderBySalesController
                                          .selectedOrder
                                          .value
                                          .products[index]
                                          .thickness
                                          .toStringAsFixed(2)),
                                ),
                                Obx(
                                  () => ReadyMadeTextTile(
                                      label: "Width",
                                      value: _editOrderBySalesController
                                          .selectedOrder
                                          .value
                                          .products[index]
                                          .width
                                          .toStringAsFixed(2)),
                                ),
                                Obx(
                                  () => ReadyMadeTextTile(
                                      label: "Len",
                                      value: _editOrderBySalesController
                                          .selectedOrder
                                          .value
                                          .products[index]
                                          .length
                                          .toStringAsFixed(2)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: size.width / 20,
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => ReadyMadeTextTile(
                                      label: "TopColor",
                                      value: _editOrderBySalesController
                                          .selectedOrder
                                          .value
                                          .products[index]
                                          .topcolor
                                          .toString()),
                                ),
                                Obx(
                                  () => ReadyMadeTextTile(
                                    label: "Pcs",
                                    value: _editOrderBySalesController
                                        .selectedOrder.value.products[index].pcs
                                        .toString(),
                                  ),
                                ),
                                Obx(
                                  () => ReadyMadeTextTile(
                                    label: "Weight",
                                    value: _editOrderBySalesController
                                        .selectedOrder
                                        .value
                                        .products[index]
                                        .weight
                                        .toStringAsFixed(2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 80,
                    ),
                    role == 1 || role == 2
                        ? Row(
                            children: [
                              Obx(() => ReadyMadeTextTile(
                                  label: "Rate(BASIC)",
                                  value: _editOrderBySalesController
                                      .selectedOrder.value.products[index].rate
                                      .toString())),
                              Obx(() => ReadyMadeTextTile(
                                  label: "Ratr(GST)",
                                  value: _editOrderBySalesController
                                      .selectedOrder.value.products[index].gst
                                      .toString()))
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
