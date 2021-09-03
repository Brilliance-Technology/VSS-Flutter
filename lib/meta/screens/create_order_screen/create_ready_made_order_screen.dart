import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/common/date_picker.dart';
import 'package:inventory_management/meta/screens/create_order_screen/components/custom_text_field.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class CreateReadyMadeOrderScreen extends StatefulWidget {
  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  _CreateReadyMadeOrderScreenState createState() =>
      _CreateReadyMadeOrderScreenState();
}

class _CreateReadyMadeOrderScreenState
    extends State<CreateReadyMadeOrderScreen> {
  final CustomDatePicker _customDatePicker = CustomDatePicker(false);
  final TextEditingController _vendorTextController =
      TextEditingController(text: "");

  final TextEditingController _quantityTextController =
      TextEditingController(text: "");

  final TextEditingController _receivedByTextController =
      TextEditingController(text: "");

  final TextEditingController _mobileNumberController =
      TextEditingController(text: "");

  final TextEditingController _totalWeightTextController =
      TextEditingController(text: "");

  final TextEditingController _remarkController =
      TextEditingController(text: "");
  final TextEditingController _rateController = TextEditingController(text: "");
  DateTime _date;
  final TextEditingController _dateController =
      TextEditingController(text: CreateReadyMadeOrderScreen.formattedDate);


  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    return Scaffold(
      appBar: appBar(title: "Edit Dispatch Details", leadingWidget: null),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: "Vendor",
                  textController: _vendorTextController,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null) {
                      return "Please Enter Vendor";
                    }
                    return null;
                  },
                ),
                vSizedBox2,
                textFieldDeliveryDate(),
                vSizedBox2,
                CustomTextField(
                  labelText: "Quantity",
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  textController: _quantityTextController,
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter Quantity";
                    }
                    return null;
                  },
                ),
                vSizedBox2,
                CustomTextField(
                  labelText: "Remark",
                  textInputType: TextInputType.text,
                  textController: _remarkController,
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter Remark";
                    }
                    return null;
                  },
                ),
                vSizedBox2,
                CustomTextField(
                  labelText: "Rate",
                  textController: _rateController,
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter Rate ";
                    }
                    return null;
                  },
                ),
                vSizedBox2,
                CustomTextField(
                  labelText: "Received By",
                  textController: _receivedByTextController,
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter Receiver Name";
                    }
                    return null;
                  },
                ),
                vSizedBox2,
                CustomTextField(
                  labelText: "Mobile No",
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter Mobile Number";
                    }
                    return null;
                  },
                  textController: _mobileNumberController,
                ),
                vSizedBox2,
                CustomTextField(
                  
                  labelText: "Total Weight",
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter Total Weight";
                    }
                    return null;
                  },
                  textController: _totalWeightTextController,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        onPressed: () {
          print(_dateController.value.text);
          _key.currentState.validate()
              ? Get.snackbar("Thankyou", "Order Added")
              : Get.snackbar("Error", "Please Fill required fields");
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }


  Widget textFieldDeliveryDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            onTap: () {
              _customDatePicker.selectDate(
                context: context,
                dateController: _dateController,
                deliveryDate: _date,
              );
            },
            readOnly: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: bgEditText,
              filled: true,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: etHintColor,
              ),
              labelText: "Date",
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  )),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              // hintText: 'Firm Name',
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    
    _vendorTextController.dispose();
    _dateController.dispose();
    _mobileNumberController.dispose();
    _quantityTextController.dispose();
    _remarkController.dispose();
    _rateController.dispose();
    _totalWeightTextController.dispose();
    super.dispose();
  }
}
