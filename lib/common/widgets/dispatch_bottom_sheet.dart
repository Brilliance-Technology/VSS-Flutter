import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/orders_controller.dart';
import 'package:inventory_management/meta/screens/create_order_screen/components/custom_text_field.dart';

class DispatchBottomSheet extends StatefulWidget {
  final int index;

  DispatchBottomSheet({this.index});

  @override
  _DispatchBottomSheetState createState() => _DispatchBottomSheetState();
}

class _DispatchBottomSheetState extends State<DispatchBottomSheet> {
  final OrderController _orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print(_orderController.productIndex.value);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: size.height / 2.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          Text(
            "Weight",
          ),
          Spacer(),
          Container(
            width: size.width / 2.5,
            child: CustomTextField(
              value: _orderController
                  .currentOrder.value.products[widget.index].weight
                  .toString(),
              onChange: (value) {
                _orderController.dispactchUpdatedWeightSingleProduct.value =
                    double.parse(value);
              },
              textInputType: TextInputType.number,
            ),
          ),
          Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}
