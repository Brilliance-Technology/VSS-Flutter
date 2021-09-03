import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/edit_order_by_sales_controller.dart';
import 'package:inventory_management/app/controllers/orders_controller.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/common/date_picker.dart';
import 'package:inventory_management/common/widgets/cart_list_item.dart';
import 'package:inventory_management/meta/screens/create_order_screen/components/custom_text_field.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/edit_order_by_sales.dart';
import 'package:inventory_management/meta/screens/user_profile_screen/widgets/detail_row.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';
import 'package:page_transition/page_transition.dart';

class ViewOrderScreen extends StatefulWidget {
  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  const ViewOrderScreen({
    Key key,
  }) : super(key: key);

  @override
  _ViewOrderScreenState createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  AppPrefs _appPrefs = AppPrefs();
  UserModel _userModel;
  var isEditable = false;
  var isSalesManager = false;
  int role;
  String pIId;
  final EditOrderBySalesController _editOrderBySalesController =
      Get.put(EditOrderBySalesController());
  final OrderController _orderController = Get.find();
  loadSharedPrefs(BuildContext context) async {
    try {
      UserModel user = await _appPrefs.readUser(Constants.user_key);
      // print(user.data.token);
      setState(() {
        _userModel = user;
        setState(() {
          // role1=sales,role2=productionHead,3=productionIncharge,4=dipage
          role = int.parse(_userModel.data.role);
          pIId = _userModel.data.id;
        });
        // if (int.tryParse(_userModel.data.role) == 2) {
        //   isEditable = true;
        // } else {
        //   isEditable = false;
        //   if(_userModel.data.role=="1"){
        //
        //     isSalesManager=true;
        //   }
        // }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    Future.delayed(Duration(seconds: 1), () {
      _orderController.isLoading.value = true;
      _orderController.getAllOrders(
          1, 10, _orderController.orderStatusValue.value);
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    loadSharedPrefs(context);
  }

  final CustomDatePicker _customDatePicker = CustomDatePicker(false);
  final TextEditingController _vehicalController =
      TextEditingController(text: "");

  final TextEditingController _receivedByTextController =
      TextEditingController(text: "");

  final TextEditingController _mobileNumberController =
      TextEditingController(text: "");

  final TextEditingController _totalWeightTextController =
      TextEditingController(text: "");

  DateTime _date;
  final TextEditingController _dateController =
      TextEditingController(text: ViewOrderScreen.formattedDate);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorDark,
        appBar: appBar(
          title: "View Order",
          leadingWidget: BackButton(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Stack(
              children: [
                Container(
                  height: Get.size.height,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                ),
                Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 16,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildDetailRow(
                              title: "Client Name",
                              data: _orderController
                                  .currentOrder.value.clientName
                                  .toString(),
                            ),
                            vSizedBox1,
                            buildDetailRow(
                              title: "Date",
                              data:
                                  _orderController.currentOrder.value.orderDate,
                            ),
                            vSizedBox1,
                            buildDetailRow(
                              title: "Delivery Date",
                              data: _orderController
                                  .currentOrder.value.deliveryDate,
                            ),
                            vSizedBox1,
                            buildDetailRow(
                              title: "Order ID",
                              data: _orderController.currentOrder.value.orderId,
                            ),
                            vSizedBox1,
                            buildDetailRow(
                              title: "Address",
                              data:
                                  "${_orderController.currentOrder.value.address}, ${_orderController.currentOrder.value.city}",
                            ),
                            vSizedBox1,
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Text(
                                "Products :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: role == 3
                            ? _orderController.currentOrder.value.products
                                .where((element) => element.phId == pIId)
                                .toList()
                                .length
                            : _orderController
                                .currentOrder.value.products.length,
                        itemBuilder: (context, index) {
                          var productList = role == 3
                              ? _orderController.currentOrder.value.products
                                  .where((element) => element.phId == pIId)
                                  .toList()
                              : _orderController.currentOrder.value.products;
                          return CartItemTile(
                            index: index,
                            product: productList[index],
                            isEditable: false,
                            orderId: _orderController.currentOrder.value.id
                                .toString(),
                            role: role,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    role == 4 &&
                            (_orderController.currentOrder.value.dpRecieved ==
                                    "null" ||
                                _orderController
                                        .currentOrder.value.dpRecieved ==
                                    null)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.size.width / 30, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryProductTileColor,
                                  borderRadius: BorderRadius.circular(23)),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TextField(
                                    //   controller: _dateController,
                                    //   keyboardType: TextInputType.datetime,
                                    //   onTap: () {
                                    //     _customDatePicker.selectDate(
                                    //         context: context,
                                    //         dateController: _dateController,
                                    //         deliveryDate: _date,
                                    //         orderDate: _orderController
                                    //             .currentOrder.value.orderDate);
                                    //   },
                                    //   readOnly: true,
                                    //   textInputAction: TextInputAction.done,
                                    //   decoration: InputDecoration(
                                    //     border: OutlineInputBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //       borderSide: BorderSide.none,
                                    //     ),
                                    //     fillColor: bgEditText,
                                    //     filled: true,
                                    //     hintStyle: TextStyle(
                                    //       fontWeight: FontWeight.w500,
                                    //       color: etHintColor,
                                    //     ),
                                    //     labelText: "Delivery Date",
                                    //     labelStyle: TextStyle(
                                    //       fontSize: 16,
                                    //       color: Colors.black87,
                                    //     ),
                                    //     focusedBorder: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10),
                                    //         borderSide: BorderSide(
                                    //           color: Colors.blue,
                                    //         )),
                                    //     contentPadding:
                                    //         const EdgeInsets.symmetric(
                                    //       horizontal: 16,
                                    //       vertical: 0,
                                    //     ),
                                    //     // hintText: 'Firm Name',
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: Get.size.height / 80,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Driver Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Delivery Date :  12 july 2021",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                    vSizedBox2,
                                    DriverTextField(
                                      labelText: "Received By",
                                      textController: _receivedByTextController,
                                      textInputType: TextInputType.name,
                                    ),
                                    vSizedBox2,
                                    DriverTextField(
                                      labelText: "Vechile No",
                                      textInputType: TextInputType.text,
                                      textController: _vehicalController,
                                    ),
                                    vSizedBox2,
                                    DriverTextField(
                                      leading: Text("+91  "),
                                      isphoneInput: true,
                                      labelText: "Driver Number",
                                      textInputType: TextInputType.number,
                                      textController: _mobileNumberController,
                                    ),
                                    vSizedBox2,
                                    DriverTextField(
                                      labelText: "Total Weight",
                                      textInputType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      textController:
                                          _totalWeightTextController,
                                    ),
                                    vSizedBox2,
                                    // CustomTextField(
                                    //   leading: Text("+91  "),
                                    //   isphoneInput: true,
                                    //   labelText: "Driver Number",
                                    //   textInputType: TextInputType.number,
                                    //   textController: _mobileNumberController,
                                    //   validator: (value) {
                                    //     if (value == "") {
                                    //       return "Please Enter Driver No.";
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    // vSizedBox2,
                                    // CustomTextField(
                                    //   labelText: "Received By",
                                    //   textController: _receivedByTextController,
                                    //   textInputType: TextInputType.name,
                                    //   validator: (value) {
                                    //     if (value == "") {
                                    //       return "Please Enter Receiver Name";
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    // vSizedBox2,
                                    // CustomTextField(
                                    //   labelText: "Vechile No",
                                    //   textInputType: TextInputType.text,
                                    //   validator: (value) {
                                    //     if (value == "") {
                                    //       return "Please Enter Vechile Number";
                                    //     }
                                    //     return null;
                                    //   },
                                    //   textController: _vehicalController,
                                    // ),
                                    // vSizedBox2,
                                    // CustomTextField(
                                    //   labelText: "Total Weight",
                                    //   textInputType:
                                    //       TextInputType.numberWithOptions(
                                    //           decimal: true),
                                    //   validator: (value) {
                                    //     if (value == "") {
                                    //       return "Please Enter Total Weight";
                                    //     }
                                    //     return null;
                                    //   },
                                    //   textController:
                                    //       _totalWeightTextController,
                                    // ),

                                    vSizedBox2,
                                  ],
                                ),
                              ),
                            ),
                          )
                        : role == 4
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.size.width / 20,
                                        ),
                                        Text(
                                          "Date",
                                          style: Constants.labelTextStyle
                                              .copyWith(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: Get.size.width / 20,
                                        ),
                                        Text("Driver Number",
                                            style: Constants.labelTextStyle
                                                .copyWith(fontSize: 17)),
                                        SizedBox(
                                          height: Get.size.width / 20,
                                        ),
                                        Text(
                                          "Driver Name",
                                          style: Constants.labelTextStyle
                                              .copyWith(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: Get.size.width / 20,
                                        ),
                                        Text(
                                          "Vehicle Number",
                                          style: Constants.labelTextStyle
                                              .copyWith(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: Get.size.width / 20,
                                        ),
                                        Text(
                                          "Total Weight",
                                          style: Constants.labelTextStyle
                                              .copyWith(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: Get.size.width / 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.size.width / 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                              _orderController
                                                  .currentOrder.value.dpDate
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54)),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                              _orderController
                                                  .currentOrder.value.dpPhone
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54)),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                              _orderController
                                                  .currentOrder.value.dpRecieved
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54)),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                              _orderController
                                                  .currentOrder.value.vehicleNum
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54)),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                              _orderController.currentOrder
                                                  .value.dpTotalWeight
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54)),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: role == 1 &&
                _orderController.isOderCanEdit(
                        _orderController.currentOrder.value.createdOrderTime) ==
                    true &&
                _orderController.currentOrder.value.orderStatus == 0
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: kButtonColorPrimary,
                      onPressed: () {
                        _editOrderBySalesController.selectedOrder.value =
                            _orderController.currentOrder.value;
                        Navigator.push(
                          context,
                          PageTransition(
                            // duration: Duration(milliseconds: 500),
                            child: EditOrderBySalesScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      label: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : role == 4 &&
                    (_orderController.currentOrder.value.dpRecieved == "null" ||
                        _orderController.currentOrder.value.dpRecieved == null)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          backgroundColor: kButtonColorPrimary,
                          onPressed: () {
                            if (_receivedByTextController.text.isNotEmpty &&
                                _vehicalController.text.isNotEmpty &&
                                _totalWeightTextController.text.isNotEmpty &&
                                (_mobileNumberController.text.isNotEmpty ||
                                    _mobileNumberController.text.length ==
                                        10)) {
                              _orderController
                                  .orderList[
                                      _orderController.currentOrderIndex.value]
                                  .dpRecieved = "assigned";
                              _orderController.addDispatchDetails(
                                  context: context,
                                  dpDate: _dateController.text,
                                  tw: double.parse(
                                      _totalWeightTextController.text),
                                  recivedby: _receivedByTextController.text,
                                  phone:
                                      int.parse(_mobileNumberController.text),
                                  vehicleNo: _vehicalController.text);
                            } else
                              showFlash(
                                  context: context,
                                  duration: Duration(seconds: 2),
                                  builder: (context, controller) {
                                    return Flash.dialog(
                                      controller: controller,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      backgroundColor: kPrimaryColorTextDark,
                                      alignment: Alignment.bottomCenter,
                                      margin:
                                          const EdgeInsets.only(bottom: 120),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Please fill all the details',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
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
                : null

//       !isEditable
//           ?

//             :isSalesManager
//           ? :null
        );
  }
}

class DriverTextField extends StatelessWidget {
  // const DriverTextField({Key? key}) : super(key: key);
  final TextEditingController textController;
  final String labelText;
  final Function validator;
  final Function onChange;
  final bool isphoneInput;

  final TextInputType textInputType;
  final double padding;
  final String value;
  final Widget leading;
  DriverTextField(
      {this.textController,
      this.labelText,
      this.isphoneInput,
      this.validator,
      this.textInputType,
      this.padding,
      this.onChange,
      this.leading,
      this.value});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.center,
      //padding: EdgeInsets.only(right: 10),
      height: 60,
      //  Get.size.width,
      child: Card(
        elevation: 11,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        child: TextFormField(
          // controller: textController,

          //  textInputAction: TextInputAction.next,
          initialValue: value,
          onChanged: onChange,
          validator: validator,
          controller: textController,
          keyboardType: textInputType,
          maxLength: isphoneInput == true ? 10 : 50,
          //style: TextStyle(fontSize: 14),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefix: leading,
            labelText: labelText,
            counterText: "",
            // prefix: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(23),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            // errorBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(23),
            //     borderSide: BorderSide(
            //       color: Colors.red,
            //     )),

            // errorText: "",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(23),
                borderSide: BorderSide(
                  color: kPrimaryColorDark,
                )),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: etHintColor,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),

            // hintText: 'Client Name',
          ),
        ),
      ),
    );
  }
}
