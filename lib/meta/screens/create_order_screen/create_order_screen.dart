import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/data/models/order_model.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/meta/screens/all_products_list/all_products_list.dart';
import 'package:inventory_management/meta/screens/order_details.dart/order_details.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';
import 'package:inventory_management/provider/cart_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _prefs.readUser(Constants.user_key).then((value) => _user = value);
    super.initState();
  }

  final AppPrefs _prefs = AppPrefs();
  UserModel _user;
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _firmNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final TextEditingController _dateController =
      TextEditingController(text: formattedDate);

  DateTime deliveryDate;

  final TextEditingController _deliveryDateController =
      TextEditingController(text: formattedDate);

  var selectedRadio = 0;
  String productName;

  var orderId = DateTime.now().millisecondsSinceEpoch;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      if (val == 1) {
        productName = "GPC";
      } else if (val == 2) {
        productName = "GPS/ROLL";
      } else if (val == 3) {
        productName = "GC COIL";
      } else if (val == 4) {
        productName = "GCS";
      } else if (val == 5) {
        productName = "COLOR COIL";
      } else if (val == 6) {
        productName = "HR";
      } else if (val == 7) {
        productName = "ACCE.";
      } else if (val == 8) {
        productName = "CR";
      } else if (val == 9) {
        productName = "PROFILE S";
      }
    });
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  Future buildMaterialDatePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
          ),
          child: child,
        );
      },
    );

    if (newDate == null) return;

    setState(() {
      deliveryDate = newDate;
      String formattedDeliveryDate =
          DateFormat('dd-MM-yyyy').format(deliveryDate);
      _deliveryDateController.value =
          TextEditingValue(text: formattedDeliveryDate);
    });
  }

  buildCupertinoDatePicker(BuildContext context) {
    final initialDate = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked == null) return;
                setState(() {
                  deliveryDate = picked;
                  String formattedDeliveryDate =
                      DateFormat('dd-MM-yyyy').format(deliveryDate);
                  _deliveryDateController.value =
                      TextEditingValue(text: formattedDeliveryDate);
                });
              },
              initialDateTime: initialDate,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 1,
            ),
          );
        });
  }

  addToCart() async {
    OrderModel orderModel = OrderModel(
        orderId: orderId.toString(),
        clientName: _clientNameController.text,
        firmName: _firmNameController.text,
        address: _addressController.text,
        city: _cityController.text,
        phoneNo: int.tryParse(_phoneController.text),
        deliveryDate: _deliveryDateController.text,
        currentDate: _dateController.text,
        note: _noteController.text,
        processBar: 1,
        products: [],
        assignDate: "null",
        completionDate: "null",
        phNote: "null",
        productionincharge: "null",
        dpDate: "null",
        dpPhone: 0,
        dpRecieved: "null",
        dpTotalWeight: 0.0,
        smName: "null",
        vehicleNum: "null",
        salesName: _user.data.firstName + _user.data.lastName,
        salesId: _user.data.id,
        orderStatus: 0);
    Provider.of<CartProvider>(context, listen: false).addOrder(orderModel);
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _firmNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _deliveryDateController.dispose();

    super.dispose();
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  Future<bool> _willPopCallback(model) async {
    // await showDialog or Show add banners or whatever
    // then
    if (model == null) {
      return true;
    } else {
      return showDialog(
              context: context,
              builder: (context) => Dialog(
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColorLight,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  child: Text(
                                    "Product",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorTextDark,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          vSizedBox1,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Are you sure?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text('If you press YES Cart will clear',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5))),
                                SizedBox(
                                  height: Get.size.height / 80,
                                ),
                                Center(
                                  child: TextButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kButtonColorPrimary,
                                      onPrimary: Colors.white,
                                      onSurface: kButtonColorPrimary,
                                      // padding: const EdgeInsets.symmetric(
                                      //   horizontal: ,
                                      //   vertical: 6,
                                      // ),

                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    onPressed: () {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .orderModel = null;
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .products = [];
                                      return Navigator.of(context).pop(true);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))

          //  showDialog(
          //       context: context,
          //       builder: (context) => new AlertDialog(
          //         title: new Text('Are you sure?'),
          //         content: new,
          //         actions: <Widget>[
          //           new GestureDetector(
          //             onTap: () {
          //               return Navigator.of(context).pop(false);
          //             },
          //             child: roundedButton(
          //                 "No", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
          //           ),
          //           new GestureDetector(
          //             onTap: () {
          //               Provider.of<CartProvider>(context, listen: false)
          //                   .orderModel = null;
          //               Provider.of<CartProvider>(context, listen: false).products =
          //                   [];
          //               return Navigator.of(context).pop(true);
          //             },
          //             child: roundedButton(" Yes ", const Color(0xFF167F67),
          //                 const Color(0xFFFFFFFF)),
          //           ),
          //         ],
          //       ),
          //     ) ??
          ??
          false;
    }
    // return true if the route to be popped
  }

  bool isExit = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kPrimaryColorDark,
        appBar: appBar(
          title: "Create Order",
          leadingWidget: BackButton(
            color: Colors.white,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Badge(
                badgeContent: Text(
                  "${model.products.length}",
                  style: TextStyle(
                    color: kPrimaryColorDark,
                    fontSize: 12,
                  ),
                ),
                badgeColor: kPrimaryColorLight,
                position: BadgePosition.topEnd(
                  top: 2,
                  end: 2,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 500),
                          child: AllProductsList(),
                          type: PageTransitionType.topToBottom),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: WillPopScope(
            onWillPop: () => _willPopCallback(model),
            child: Form(key: _formkey, child: createOrderBody())),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kButtonColorPrimary,
            onPressed: () {
              if (productName == null ||
                  _clientNameController.text.isEmpty ||
                  _firmNameController.text.isEmpty ||
                  _addressController.text.isEmpty ||
                  _cityController.text.isEmpty ||
                  _phoneController.text.isEmpty &&
                      _phoneController.text.length == 10 ||
                  _dateController.text.isEmpty) {
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
              } else {
                if (_formkey.currentState.validate()) {
                  addToCart();
                  Navigator.push(
                    context,
                    PageTransition(
                        duration: Duration(milliseconds: 200),
                        child: OrderDetails(
                          orderId: orderId.toString(),
                          productName: productName,
                        ),
                        type: PageTransitionType.rightToLeft),
                  );
                }
              }
            },
            child: Text(
              "NEXT",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Widget createOrderBody() {
    return Container(
      width: Get.size.width,
      height: Get.size.height,
      decoration: BoxDecoration(
          color: Color(0xffF5F8FD),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      padding: const EdgeInsets.only(
          left: 24,
          right: 0,
          bottom: 16,
          top: 2), //symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Date  : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  Text(
                    _dateController.text,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.size.height / 90,
            ),
            textWidget(),
            vSizedBox2,
            // textfieldClient(),
            FormTextField(
              widthDivision: 1,
              textController: _clientNameController,
              label: "Client",
            ),
            vSizedBox2,
            FormTextField(
              widthDivision: 1,
              textController: _firmNameController,
              label: "Firm",
            ),
            vSizedBox2,
            //textFieldAddress(),
            FormTextField(
              widthDivision: 1,
              textController: _addressController,
              label: "Address",
            ),
            vSizedBox2,
            Container(
              //height: 100,
              child: Row(
                children: [
                  FormTextField(
                    widthDivision: 3,
                    textController: _cityController,
                    label: "City",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  textFieldPhoneNumber()
                ],
              ),
            ),
            // textfieldCity(),
            vSizedBox2,

            // textFieldPhoneNumber(),
            // vSizedBox2,
            // textFieldCurrentDate(),

            textFieldDeliveryDate(),
            vSizedBox1,
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Card(
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: Get.size.width / 30),
                  decoration: BoxDecoration(
                      color: kPrimaryColorLight.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(23)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.size.height / 50,
                      ),
                      firstRow(),
                      SizedBox(
                        height: Get.size.height / 50,
                      ),
                      secondRow(),
                      SizedBox(
                        height: Get.size.height / 50,
                      ),
                      thirdRow(),
                      SizedBox(
                        height: Get.size.height / 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            vSizedBox1,
            textFieldNote(),
            vSizedBox4,
          ],
        ),
      ),
    );
  }

  Text textWidget() {
    return Text(
      "Order ID - $orderId",
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(2);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 2
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "GPS/ROLL",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(1);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 1
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "GPC",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(3);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 3
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "GC COIL",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(4);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 4
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "GCS",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(6);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 6
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "HR",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(9);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 9
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "PROFILE S",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        // Flexible(
        //   child: Row(
        //     children: [
        //       Radio(
        //         value: 5,
        //         groupValue: selectedRadio,
        //         activeColor: Colors.blue,
        //         onChanged: (val) {
        //           setSelectedRadio(val);
        //         },
        //       ),
        //       Text(
        //         "COLOR COIL",
        //         style: TextStyle(
        //           fontWeight: FontWeight.w700,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(7);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 7
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "ACCE.",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(8);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 8
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "CR",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                onTap: () {
                  setSelectedRadio(5);
                  setState(() {});
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedRadio == 5
                              ? kPrimaryColorDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: 10,
                      width: 10,
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "COLOR COIL",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        // Flexible(
        //   child: Row(
        //     children: [
        //       Radio(
        //         value: 6,
        //         groupValue: selectedRadio,
        //         activeColor: Colors.blue,
        //         onChanged: (val) {
        //           setSelectedRadio(val);
        //         },
        //       ),
        //       Text(
        //         "HR",
        //         style: TextStyle(
        //           fontWeight: FontWeight.w700,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  // Widget forthRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [],
  //   );
  // }

  // Widget fifthRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [],
  //   );
  // }

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

  Widget textFieldDeliveryDate() {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              elevation: 11,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: TextField(
                controller: _deliveryDateController,
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
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
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: kPrimaryColorDark,
                      )),
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
      ),
    );
  }

  Widget textFieldNote() {
    return Container(
      height: Get.size.height / 10,
      padding: EdgeInsets.only(right: 10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: _noteController,
          keyboardType: TextInputType.text,
          maxLines: 2,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,

            filled: true,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: etHintColor,
            ),
            labelText: "Note: ",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: kPrimaryColorDark,
                )),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16 // Get.size.height / 10,
                // vertical: 10,
                ),
            // hintText: 'Firm Name',
          ),
        ),
      ),
    );
  }

  Widget textFieldPhoneNumber() {
    return Container(
      height: Get.size.width / 8,
      width: (Get.size.width / 2.5) ?? Get.size.width,
      child: Card(
        elevation: 11,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          controller: _phoneController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          validator: (value) {
            if (value.isEmpty) {
              return "Please Enter Client Phone Number";
            } else if (value.length != 10 || int.tryParse(value) == null) {
              return "Please Enter Valid Phone number";
            } else
              return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: etHintColor,
            ),
            counterText: "",
            labelText: "Phone No.",
            prefixText: "+91",

            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: kPrimaryColorDark,
                )),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            // hintText: 'Firm Name',
          ),
        ),
      ),
    );
  }

  Widget textfieldCity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
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
              labelText: "City",
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

  Widget textFieldAddress() {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Expanded(
    //       child: TextField(
    //         controller: _addressController,
    //         textInputAction: TextInputAction.next,
    //         keyboardType: TextInputType.text,
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide.none,
    //           ),
    //           fillColor: bgEditText,
    //           filled: true,
    //           hintStyle: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             color: etHintColor,
    //           ),
    //           labelText: "Address",
    //           focusedBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10),
    //               borderSide: BorderSide(
    //                 color: Colors.blue,
    //               )),
    //           contentPadding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //             vertical: 0,
    //           ),
    //           // hintText: 'Firm Name',
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget textfieldFirmName() {
    return FormTextField(
      textController: _firmNameController,
      label: "Firm Name",
    );
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Expanded(
    //       child: TextField(
    //         controller: _firmNameController,
    //         textInputAction: TextInputAction.next,
    //         keyboardType: TextInputType.text,
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide.none,
    //           ),
    //           fillColor: bgEditText,
    //           filled: true,
    //           hintStyle: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             color: etHintColor,
    //           ),
    //           labelText: "Firm Name",
    //           focusedBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10),
    //               borderSide: BorderSide(
    //                 color: Colors.blue,
    //               )),
    //           contentPadding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //             vertical: 0,
    //           ),
    //           // hintText: 'Firm Name',
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget textfieldClient() {
    return FormTextField(
      textController: _clientNameController,
      label: "Client Name",
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField(
      {this.label, this.textController, this.widthDivision, this.prefix});

  final TextEditingController textController;
  final String label;
  final Widget prefix;
  final double widthDivision;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      height: Get.size.width / 8,
      width: (Get.size.width / widthDivision) ?? Get.size.width,
      child: Card(
        elevation: 11,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: textController,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 14),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefix: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,

            labelText: label,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: kPrimaryColorDark,
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
    );
  }
}
