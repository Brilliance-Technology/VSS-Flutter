import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/edit_order_by_sales_controller.dart';
import 'calculate_dialoge_sales.dart';

class LengthWidgetSales extends StatefulWidget {
  @override
  _LengthWidgetSalesState createState() => _LengthWidgetSalesState();
}

final EditOrderBySalesController _editOrderBySalesController = Get.find();

class _LengthWidgetSalesState extends State<LengthWidgetSales> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Length",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        SizedBox(
          height: 6,
        ),
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CalculateDialogSales();
                  }).then((value) {
                if (value != null) {
                  _editOrderBySalesController.selectedLength.value =
                      double.tryParse(value.toString());
                }
                print("Length is $widget.length");
              });
            },
            child: Container(
              child: Card(
                shadowColor: Colors.black.withOpacity(0.5),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => Text(
                      _editOrderBySalesController.selectedLength.toString(),
                      style: TextStyle(
                        color: kPrimaryColorDark,
                        fontSize: 12,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
