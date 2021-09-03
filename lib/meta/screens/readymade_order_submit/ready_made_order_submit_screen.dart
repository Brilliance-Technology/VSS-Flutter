import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/controllers/rate_controller.dart';
import 'package:inventory_management/app/controllers/ready_made_order_submit_controller.dart';
import 'package:inventory_management/app/data/models/order_model.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/app/data/models/ready_made_model.dart';
import 'package:inventory_management/common/date_picker.dart';
import 'package:inventory_management/meta/screens/create_order_screen/components/custom_text_field.dart';
import 'package:inventory_management/meta/screens/create_order_screen/create_order_screen.dart';
import 'package:inventory_management/meta/screens/readymade/components/ready_product_details.dart';
import 'package:inventory_management/meta/screens/readymade/ready_made_product_detail.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class ReadyMadeOrderSubmitScreen extends StatefulWidget {
  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final ReadyMade product;
  ReadyMadeOrderSubmitScreen({this.product});
  @override
  _ReadyMadeOrderSubmitScreenState createState() =>
      _ReadyMadeOrderSubmitScreenState();
}

class _ReadyMadeOrderSubmitScreenState
    extends State<ReadyMadeOrderSubmitScreen> {
  ReadyMadeOrderSubmitController _readyMadeOrderSubmitController =
      Get.put(ReadyMadeOrderSubmitController());
  TextEditingController _clientNameController = TextEditingController();

  TextEditingController _firmNameController = TextEditingController();

  TextEditingController _addressController = TextEditingController(text: "");

  TextEditingController _cityController = TextEditingController();
  final DashBoardController _dashBoardController = Get.find();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _noteController = TextEditingController();

  TextEditingController _dateController =
      TextEditingController(text: ReadyMadeOrderSubmitScreen.formattedDate);
  final RateController _rateGetXController = Get.put(RateController());
  DateTime deliveryDate;

  final TextEditingController _deliveryDateController =
      TextEditingController(text: ReadyMadeOrderSubmitScreen.formattedDate);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String orderID = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: appBar(
          title: "Client Details",
          leadingWidget: BackButton(
            color: Colors.white,
          )),
      body: Container(
        height: Get.size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23), color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Id : " + orderID,
                      style: TextStyle(color: kPrimaryColorDark),
                    ),
                    Text(
                      "Date : ${_dateController.text}",
                      style: TextStyle(color: kPrimaryColorDark),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    textController: _clientNameController,
                    // validator: (value) {
                    //   if (value.toString().length < 2) {
                    //     return "Enter Client Name";
                    //   } else
                    //     return null;
                    // },

                    labelText: "Client Name",
                    padding: 10,
                    textInputType: TextInputType.text),
                SizedBox(
                  height: Get.size.height / 80,
                ),
                CustomTextField(
                    textController: _firmNameController,
                    // validator: (value) {
                    //   if (value.toString().isEmpty) {
                    //     return "Enter Firm Name";
                    //   } else
                    //     return null;
                    // },

                    labelText: "Firm Name",
                    padding: 10,
                    textInputType: TextInputType.text),
                SizedBox(
                  height: Get.size.height / 80,
                ),
                CustomTextField(
                    textController: _addressController,

                    // validator: (value) {
                    //   if (value.toString().length == 0) {
                    //     return "Please Enter Delivery Address";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    labelText: "Address",
                    padding: 10,
                    textInputType: TextInputType.text),
                SizedBox(
                  height: Get.size.height / 80,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          textController: _cityController,

                          // validator: (value) {
                          //   if (value.toString().length == 0) {
                          //     return "Please Enter City Name";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          labelText: "City",
                          padding: 10,
                          textInputType: TextInputType.text),
                    ),
                    Expanded(
                      child: CustomTextField(
                        leading: Text("+91  "),
                        textController: _phoneController,
                        isphoneInput: true,
                        textInputType: TextInputType.number,
                        labelText: "Phone",
                        // validator: (value) {
                        //   if (value.toString().length != 10) {
                        //     return "Enter Valid Number";
                        //   } else
                        //     return null;
                        // },
                      ),
                    ),
                  ],
                ),
                // Padding(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: textFieldCurrentDate()),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: textFieldDeliveryDate(context)),
                CustomTextField(
                  textController: _noteController,
                  padding: 10,
                  textInputType: TextInputType.text,
                  labelText: "Note",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox3,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 11,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)),
                            shadowColor: Colors.grey.withOpacity(0.5),
                            child: TextFormField(
                              //controller: _rateController,

                              onChanged: (value) {
                                _rateGetXController.rate.value =
                                    double.tryParse(
                                            value.replaceAll(",", "")) ??
                                        0.0;

                                _rateGetXController.rateWithGST.value =
                                    (_rateGetXController.rate.value) +
                                        (0.18 * _rateGetXController.rate.value);
                              },
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Please Enter Rate";
                              //   } else if (int.tryParse(value) == null ||
                              //       int.tryParse(value) < 1) {
                              //     return "Please Enter rate in right formate";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Rate",
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    )),
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: etHintColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 0,
                                ),

                                // hintText: 'Client Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                              top: 2,
                            ),
                            child: Text(
                              "Basic",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)),
                            elevation: 11,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 20,
                                  vertical: Get.size.width / 30),
                              width: Get.width,
                              //controller: _gstRateController,

                              child: Obx(
                                () => Text(
                                  _rateGetXController.rateWithGST.value
                                      .toString(),
                                ),
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                              top: 2,
                            ),
                            child: Text(
                              "GST",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                OrderTextButton(
                  text: "Submit",
                  onPressed: () {
                    if (_addressController.text.isNotEmpty &&
                        _cityController.text.isNotEmpty &&
                        _clientNameController.text.isNotEmpty &&
                        (_phoneController.text.length == 10 ||
                            int.tryParse(_phoneController.text) != null)) {
                      _readyMadeOrderSubmitController.orderSubmit(
                          OrderModel(
                              clientName: _clientNameController.text,
                              address: _addressController.text,
                              city: _clientNameController.text,
                              phoneNo: int.parse(_phoneController.text),
                              orderId: orderID,
                              assignDate: _dateController.text,
                              deliveryDate: _deliveryDateController.text,
                              note: _noteController.text,
                              orderStatus: 2,
                              salesId:
                                  _dashBoardController.userModel.value.data.id,
                              salesName: _dashBoardController
                                      .userModel.value.data.firstName
                                      .toString() +
                                  _dashBoardController
                                      .userModel.value.data.lastName
                                      .toString(),
                              products: [
                                Product(
                                    id: widget.product.id,
                                    isOrderReady: true,
                                    selectProduct: widget.product.selectProduct,
                                    // productId: widget.product.productId,
                                    company: widget.product.company,
                                    grade: widget.product.grade,
                                    topcolor: widget.product.topcolor,
                                    coatingnum: widget.product.coating,
                                    temper: widget.product.temper,
                                    guardfilm: widget.product.guardFilm,
                                    thickness: widget.product.thickness,
                                    width: widget.product.width,
                                    length: widget.product.length,
                                    pcs: widget.product.pcs,
                                    weight: widget.product.weight,
                                    rate: _rateGetXController.rate.value,
                                    gst: _rateGetXController.rateWithGST.value,
                                    batchList: [])
                              ]),
                          context);
                      _rateGetXController.rate.value = 0;
                      _rateGetXController.rateWithGST.value = 0;
                    } else {
                      showFlash(
                          context: context,
                          duration: Duration(seconds: 2),
                          builder: (context, controller) {
                            return Flash.dialog(
                              controller: controller,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              backgroundColor: kPrimaryColorDark,
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.only(bottom: 120),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Please fill all the details to continue',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldDeliveryDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 8,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: TextField(
              controller: _deliveryDateController,
              keyboardType: TextInputType.datetime,
              onTap: () {
                setState(() {
                  CustomDatePicker(false).selectDate(
                      context: context,
                      deliveryDate: deliveryDate,
                      dateController: _deliveryDateController);
                });
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
                    borderRadius: BorderRadius.circular(10),
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

  Widget textFieldCurrentDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _dateController,
            enabled: false,
            keyboardType: TextInputType.text,
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
}
