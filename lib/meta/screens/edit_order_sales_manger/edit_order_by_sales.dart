import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/controllers/edit_order_by_sales_controller.dart';
import 'package:inventory_management/common/date_picker.dart';
import 'package:inventory_management/common/widgets/cart_list_item.dart';
import 'package:inventory_management/meta/screens/create_order_screen/components/custom_text_field.dart';
import 'package:inventory_management/meta/screens/create_order_screen/create_ready_made_order_screen.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/components/product_tile_sales_edit.dart';

import 'package:inventory_management/meta/widgets/app_bar.dart';

class EditOrderBySalesScreen extends StatefulWidget {
  static EditOrderBySalesController _editOrderBySalesController =
      Get.put(EditOrderBySalesController());
  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  _EditOrderBySalesScreenState createState() => _EditOrderBySalesScreenState();
}

class _EditOrderBySalesScreenState extends State<EditOrderBySalesScreen> {
  @override
  void initState() {
    _clientNameController = TextEditingController(
        text: _editOrderBySalesController.selectedOrder.value.clientName);

    _firmNameController = TextEditingController(
        text: _editOrderBySalesController.selectedOrder.value.firmName);

    _addressController = TextEditingController(
        text: _editOrderBySalesController.selectedOrder.value.address);

    _cityController = TextEditingController(
        text: _editOrderBySalesController.selectedOrder.value.city);

    _phoneController = TextEditingController(
        text:
            _editOrderBySalesController.selectedOrder.value.phoneNo.toString());

    _noteController = TextEditingController(
        text: _editOrderBySalesController.selectedOrder.value.note);
    _dateController = TextEditingController(
        text: _editOrderBySalesController.selectedOrder.value.deliveryDate);

    super.initState();
  }

  @override
  void dispose() {
    _editOrderBySalesController.selectedOrder.value = null;
    // TODO: implement dispose
    super.dispose();
  }

  final CustomDatePicker _datePicker = CustomDatePicker(false);
  final EditOrderBySalesController _editOrderBySalesController = Get.find();
  TextEditingController _clientNameController;
  final DashBoardController _dashBoardController = Get.find();
  TextEditingController _firmNameController;

  TextEditingController _addressController;
  TextEditingController _cityController;

  TextEditingController _phoneController;

  TextEditingController _noteController;

  DateTime _date;

  TextEditingController _dateController;

  @override
  Widget build(BuildContext context) {
    print(EditOrderBySalesScreen
        ._editOrderBySalesController.selectedOrder.value.clientName
        .toString());
    return Scaffold(
        backgroundColor: kPrimaryColorDark,
        appBar: appBar(
            title: "Order Edit",
            leadingWidget: BackButton(
              color: Colors.white,
            )),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      CustomTextField(
                        textInputType: TextInputType.name,
                        labelText: "Client Name",
                        padding: 10,
                        textController: _clientNameController,
                      ),
                      vSizedBox2,
                      CustomTextField(
                        textInputType: TextInputType.text,
                        labelText: "Firm Name",
                        padding: 10,
                        textController: _firmNameController,
                      ),
                      vSizedBox2,
                      CustomTextField(
                        textInputType: TextInputType.text,
                        labelText: "Address",
                        padding: 10,
                        textController: _addressController,
                      ),
                      vSizedBox2,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              textInputType: TextInputType.text,
                              labelText: "City",
                              padding: 10,
                              textController: _cityController,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              leading: Text("+91  "),
                              textInputType: TextInputType.phone,
                              labelText: "Phone no",
                              padding: 10,
                              isphoneInput: true,
                              textController: _phoneController,
                            ),
                          ),
                        ],
                      ),
                      vSizedBox2,
                      textFieldDeliveryDate(context),
                      vSizedBox2,
                      CustomTextField(
                          textInputType: TextInputType.text,
                          labelText: "Note",
                          padding: 10,
                          textController: _noteController),
                    ],
                  ),
                ),
                vSizedBox2,
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    "Products :",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (EditOrderBySalesScreen._editOrderBySalesController
                        .selectedOrder.value.products.length >=
                    1)
                  Obx(
                    () => ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: 80,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _editOrderBySalesController
                          .selectedOrder.value.products.length,
                      itemBuilder: (context, index) {
                        return ProductTileSalesEdit(
                          index: index,
                          isEditable: true,
                          role: int.parse(
                              _dashBoardController.userModel.value.data.role),
                        );
                      },
                    ),
                  )
                else
                  SizedBox()
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                backgroundColor: kButtonColorPrimary,
                onPressed: () {
                  print(_editOrderBySalesController
                      .selectedOrder.value.clientName
                      .toString());
                  _editOrderBySalesController.selectedOrder.value.address =
                      _addressController.text;

                  _editOrderBySalesController.selectedOrder.value.clientName =
                      _clientNameController.text;
                  _editOrderBySalesController.selectedOrder.value.firmName =
                      _firmNameController.text;
                  _editOrderBySalesController.selectedOrder.value.city =
                      _cityController.text;
                  _editOrderBySalesController.selectedOrder.value.phoneNo =
                      int.parse(_phoneController.text);
                  _editOrderBySalesController.selectedOrder.value.note =
                      _noteController.text;
                  _editOrderBySalesController.selectedOrder.value.deliveryDate =
                      _dateController.text;
                  _editOrderBySalesController.selectedOrder.value.orderStatus =
                      0;
                  print(_editOrderBySalesController
                      .selectedOrder.value.deliveryDate
                      .toString());
                  _editOrderBySalesController.editOrderBySales(
                      order: _editOrderBySalesController.selectedOrder.value,
                      context: context);
                },
                label: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
        //
        // FloatingActionButton(
        //   onPressed: (){},
        //   backgroundColor: Colors.blue,
        //   child: Container(child: Text("Submit",style:Constants.labelTextStyle.copyWith(color: Colors.white),),),
        // ),
        );
  }

  Widget textFieldDeliveryDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            color: Colors.white,
            elevation: 11,
            shadowColor: Colors.grey.withOpacity(0.5),
            child: TextField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              onTap: () {
                _datePicker.selectDate(
                    context: context,
                    dateController: _dateController,
                    deliveryDate: _date,
                    orderDate: EditOrderBySalesScreen
                        ._editOrderBySalesController
                        .selectedOrder
                        .value
                        .deliveryDate);
              },
              readOnly: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: etHintColor,
                ),
                labelText: "Delivery Date",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23),
                    borderSide: BorderSide(color: kPrimaryColorDark)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                // hintText: 'Firm Name',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
