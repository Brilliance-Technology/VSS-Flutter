import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/production_head_controller.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/app/data/models/production_incharge_assign_model.dart';

import 'package:inventory_management/common/date_picker.dart';
import 'package:inventory_management/meta/screens/production_head/edit_order_details/edit_order_details.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

import 'package:inventory_management/provider/users_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final Product product;
  final int role;
  final String orderId;
  String selectedProductionIncharge;
  String inchargeId;
  CartScreen({Key key, this.product, this.role, this.orderId})
      : super(key: key);

  DateTime assignDate;
  DateTime completionDate;
  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final CustomDatePicker _datePicker =
      CustomDatePicker(false, isForFilter: false);
  final TextEditingController _assignDateController =
      TextEditingController(text: formattedDate);

  final TextEditingController _completionDateController =
      TextEditingController(text: formattedDate);

  final TextEditingController _noteController = TextEditingController(text: "");

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _rateController = TextEditingController();
  TextEditingController _gstController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rateController.text = widget.product.rate.toString();
    _gstController.text = widget.product.gst.toString();
  }

  final ProductionHeadController _headController =
      Get.put(ProductionHeadController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          title: "Products Detail",
          leadingWidget: BackButton(
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColorDark,
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              height: Get.size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 10,
                  right: 10,
                ),
                child: Column(children: [
                  SizedBox(height: Get.size.height / 20),
                  Card(
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(40)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSizedBox2,
                          productDetailsWidget(),
                          vSizedBox2,
                          Text(
                            "Product Id :  ${widget.product.productId}",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          ),
                          vSizedBox2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              companyDropDown(),
                              gradeDropDown(),
                              topColorDropDown(),
                            ],
                          ),
                          vSizedBox2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              coatingDropDown(),
                              temperDropDown(),
                              guardFilmDropDown(),
                            ],
                          ),
                          vSizedBox2,
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: kPrimaryColorLight,
                                borderRadius: BorderRadius.circular(23)),
                            child: Column(children: [
                              Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  thicknessColumn(),
                                  lengthColumn(),
                                  widthColumn(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pcsColumn(),
                                  weightColumn(),
                                  widget.product.isOrderReady ?? false
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: Get.size.height / 30,
                                            ),
                                            Row(
                                              children: [
                                                Card(
                                                  elevation: 5,
                                                  shadowColor: Colors.grey
                                                      .withOpacity(0.5),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                      : SizedBox()
                                ],
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          widget.role == 1 || widget.role == 2
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Rate (BASIC).",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Card(
                                          elevation: 8,
                                          shadowColor:
                                              Colors.grey.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(23)),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              widget.product.rate.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff4C7088)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Rate (GST).",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Card(
                                          elevation: 8,
                                          shadowColor:
                                              Colors.grey.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(23)),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              widget.product.gst.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff4C7088)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    // Card(
                                    //   elevation: 11,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(30),
                                    //   ),
                                    //   shadowColor: Colors.grey.withOpacity(0.5),
                                    , //   child: Container(
                                    //     width: Get.size.width / 3,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(30)),
                                    //     child: TextField(
                                    //       controller: _gstController,
                                    //       style: TextStyle(
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Color(0xff4C7088)),
                                    //       textInputAction: TextInputAction.done,
                                    //       keyboardType: TextInputType.text,
                                    //       enabled: false,
                                    //       decoration: InputDecoration(
                                    //         border: OutlineInputBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //           borderSide: BorderSide.none,
                                    //         ),
                                    //         fillColor: Colors.white,
                                    //         filled: true,
                                    //         labelText: "Rate(GST)",
                                    //         focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.blue,
                                    //             )),
                                    //         hintStyle: TextStyle(
                                    //           fontWeight: FontWeight.w500,
                                    //           color: etHintColor,
                                    //         ),
                                    //         contentPadding:
                                    //             const EdgeInsets.symmetric(
                                    //           horizontal:,
                                    //           vertical: 0,
                                    //         ),

                                    //         // hintText: 'Client Name',
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Spacer()
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: Get.size.height / 80,
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Product ReadyMade : ",
                          //       style: Constants.labelTextStyle
                          //           .copyWith(fontSize: 18),
                          //     ),
                          //     widget.product.isOrderReady
                          //         ? Icon(
                          //             Icons.check,
                          //             color: Colors.green,
                          //           )
                          //         : Icon(
                          //             Icons.cancel,
                          //             color: Colors.red,
                          //           )
                          //   ],
                          // ),
                          widget.role == 2 &&
                                  widget.product.productionIncharge == null &&
                                  widget.product.isproductionInchargAssigned ==
                                      false &&
                                  widget.product.isOrderReady == false
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColorLight,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 10, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Assign Date : " +
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(DateTime.now()),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColorDark),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.size.height / 30,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Production Incharge",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                ),
                                                Container(
                                                  //width: double.infinity,
                                                  // margin:
                                                  //     const EdgeInsets.symmetric(
                                                  //   horizontal: 24,
                                                  //   vertical: 16,
                                                  // ),
                                                  // padding: const EdgeInsets.only(
                                                  //     left: 16, right: 16),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child:
                                                      Consumer<UsersProvider>(
                                                          builder: (context,
                                                              model, child) {
                                                    _headController
                                                            .inchargeList =
                                                        model.usersList
                                                            .toList();
                                                    print("Incharge" +
                                                        _headController
                                                            .inchargeList.length
                                                            .toString());
                                                    return Card(
                                                      // padding: const EdgeInsets.only(left: 8, right: 8),
                                                      // decoration: BoxDecoration(
                                                      //   color: bgEditText,
                                                      //   borderRadius: BorderRadius.circular(10),
                                                      // ),
                                                      shadowColor: Colors.black
                                                          .withOpacity(0.5),
                                                      elevation: 11,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          23)),
                                                      child: Container(
                                                        width:
                                                            Get.size.width / 3,
                                                        height: 30,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12,
                                                                right: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: DropdownButton(
                                                          isExpanded: true,
                                                          hint: Text(
                                                              "Production Incharge"),
                                                          elevation: 0,
                                                          underline: Text(""),
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily:
                                                                "Monteserat",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff4C7088),
                                                          ),
                                                          dropdownColor: Colors
                                                              .grey.shade300,
                                                          value: widget
                                                              .selectedProductionIncharge,
                                                          // dropdownColor: Colors.grey.shade300,
                                                          onChanged:
                                                              (newValue) {
                                                            widget.selectedProductionIncharge =
                                                                newValue
                                                                    .toString();
                                                            setState(() {
                                                              print(newValue
                                                                  .toString());
                                                              widget.inchargeId = _headController
                                                                  .inchargeList
                                                                  .firstWhere((element) =>
                                                                      "${element.firstName}  ${element.lastName}" ==
                                                                      widget
                                                                          .selectedProductionIncharge)
                                                                  .id
                                                                  .toString();
                                                            });
                                                          },
                                                          items: model.isLoading
                                                              ? []
                                                              : _headController
                                                                  .inchargeList
                                                                  .map((item) {
                                                                  final String
                                                                      name =
                                                                      "${item.firstName}  ${item.lastName}";
                                                                  return DropdownMenuItem(
                                                                    value: name,
                                                                    child: Text(
                                                                        name),
                                                                  );
                                                                }).toList(),
                                                        ),
                                                      ),
                                                    );
                                                    //  DropdownButton(
                                                    //   hint: Text("Production Incharge"),
                                                    //   elevation: 0,

                                                    //   style: TextStyle(
                                                    //     fontSize: 14,
                                                    //     fontFamily: "Monteserat",
                                                    //     fontWeight: FontWeight.bold,
                                                    //     color: Colors.black,
                                                    //   ),

                                                    //   // iconSize: 0,
                                                    //   // icon: Icon(null),
                                                    //   value: widget
                                                    //       .selectedProductionIncharge,
                                                    //   dropdownColor: Colors.grey.shade300,
                                                    //   onChanged: (newValue) {
                                                    //     widget.selectedProductionIncharge =
                                                    //         newValue.toString();
                                                    //     setState(() {
                                                    //       print(newValue.toString());
                                                    //       widget.inchargeId = _headController
                                                    //           .inchargeList
                                                    //           .firstWhere((element) =>
                                                    //               "${element.firstName}  ${element.lastName}" ==
                                                    //               widget
                                                    //                   .selectedProductionIncharge)
                                                    //           .id
                                                    //           .toString();
                                                    //     });
                                                    //   },
                                                    //   items: model.isLoading
                                                    //       ? []
                                                    //       : _headController.inchargeList
                                                    //           .map((item) {
                                                    //           final String name =
                                                    //               "${item.firstName}  ${item.lastName}";
                                                    //           return DropdownMenuItem(
                                                    //             value: name,
                                                    //             child: Text(name),
                                                    //           );
                                                    //         }).toList(),
                                                    // );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Text(
                                                "Completion Date",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.7)),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                height: 40,
                                                width: (Get.size.width / 2.5),
                                                child: Card(
                                                  elevation: 11,
                                                  shadowColor: Colors.grey
                                                      .withOpacity(0.5),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextField(
                                                    controller: widget
                                                        ._completionDateController,
                                                    readOnly: true,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onTap: () async {
                                                      await widget._datePicker.selectDate(
                                                          context: context,
                                                          dateController: widget
                                                              ._completionDateController,
                                                          deliveryDate: widget
                                                              .completionDate);
                                                    },
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      // prefix: prefix,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      fillColor: Colors.white,
                                                      filled: true,

                                                      // labelText: "Completion Date",
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    kPrimaryColorDark,
                                                              )),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: etHintColor,
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 16,
                                                        vertical: 0,
                                                      ),

                                                      // hintText: 'Client Name',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                              // InputFieldWidget(
                                              //   lable: ,

                                              // ),
                                              ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.size.height / 50,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: textFieldNote(),
                                      ),
                                      // InputFieldWidget(
                                      //   lable: "Assign Date",
                                      //   deliveryDateController:
                                      //       widget._assignDateController,
                                      //   onTap: () async {
                                      //     widget._datePicker.selectDate(
                                      //         context: context,
                                      //         dateController:
                                      //             widget._assignDateController,
                                      //         deliveryDate: widget.assignDate);
                                      //   },
                                      // ),
                                      SizedBox(
                                        height: Get.size.height / 50,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: kButtonColorPrimary,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.grey,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(23),
                                          ),
                                        ),
                                        onPressed: () async {
                                          print(widget
                                              ._assignDateController.text);
                                          print(widget
                                              ._completionDateController.text);
                                          print(widget._noteController.text);
                                          print(widget
                                              .selectedProductionIncharge
                                              .toString());
                                          print(widget.orderId);
                                          print(widget.product.productId);
                                          print(widget.inchargeId.toString());
                                          await _headController.assignOrderByPH(
                                              widget.orderId,
                                              widget.product.productId,
                                              ProductionInchargeAssignModel(
                                                  productionincharge: widget
                                                      .selectedProductionIncharge
                                                      .toString(),
                                                  assignDate: DateFormat(
                                                          'dd-MM-yyyy')
                                                      .format(DateTime.now()),
                                                  completionDate: widget
                                                      ._completionDateController
                                                      .text,
                                                  pInId: widget.inchargeId,
                                                  phNote: widget
                                                      ._noteController.text));

                                          setState(() {
                                            widget.product.assignDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.now());
                                            widget.product.productionIncharge =
                                                widget
                                                    .selectedProductionIncharge;
                                            widget.product.completionDate =
                                                widget._completionDateController
                                                    .text;
                                            widget.product.phNote =
                                                widget._noteController.text;

                                            widget.product
                                                    .isproductionInchargAssigned =
                                                true;
                                          });
                                          Get.back();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Order Assigned Successfully')));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Submit',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            // hSizedBox1,
                                            // model.isLoading
                                            // ? SizedBox(
                                            //     width: 20,
                                            //     height: 20,
                                            //     child: CircularProgressIndicator(
                                            //       strokeWidth: 2,
                                            //       backgroundColor: Colors.white,
                                            //     ),
                                            //   )
                                            // : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.size.height / 50,
                                      )
                                    ],
                                  ),
                                )
                              : Visibility(
                                  visible:
                                      widget.product.productionIncharge != null,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                            "Production Incharge",
                                            style: Constants.labelTextStyle
                                                .copyWith(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text("Assign  Date",
                                              style: Constants.labelTextStyle
                                                  .copyWith(fontSize: 17)),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                            "Completion Date",
                                            style: Constants.labelTextStyle
                                                .copyWith(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: Get.size.width / 20,
                                          ),
                                          Text(
                                            "Note",
                                            style: Constants.labelTextStyle
                                                .copyWith(fontSize: 17),
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
                                                widget
                                                    .product.productionIncharge
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black54)),
                                            SizedBox(
                                              height: Get.size.width / 20,
                                            ),
                                            Text(
                                                widget.product.assignDate
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black54)),
                                            SizedBox(
                                              height: Get.size.width / 20,
                                            ),
                                            Text(
                                                widget.product.completionDate
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black54)),
                                            SizedBox(
                                              height: Get.size.width / 20,
                                            ),
                                            Text(
                                                widget.product.phNote
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black54))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.size.height / 30,
                  )
                  // Spacer()
                ])),
          ],
        )));
  }

  Widget textFieldNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(),
            child: TextField(
              controller: widget._noteController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 2,
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
                labelText: "Note",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: kPrimaryColorDark)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                // hintText: 'Firm Name',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column widthColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Width",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        SizedBox(
          height: 6,
        ),
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.width.toString() + "" + " mm",
              style: TextStyle(
                fontSize: 12,
                color: kPrimaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column lengthColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Length",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        SizedBox(
          height: 6,
        ),
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.length.toString() + " mm",
              style: TextStyle(
                fontSize: 12,
                color: kPrimaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column thicknessColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Thickness",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        SizedBox(
          height: 6,
        ),
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.thickness.toString() + " mm",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column pcsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Pcs.",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        SizedBox(
          height: 6,
        ),
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.pcs.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column weightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weight",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        SizedBox(
          height: 6,
        ),
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.weight.toString() + " Kg",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column coatingDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Coating",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        vSizedBox1,
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.coatingnum.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column temperDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Temper",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        vSizedBox1,
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.temper.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column guardFilmDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Guard",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        vSizedBox1,
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.guardfilm.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column companyDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Company",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        vSizedBox1,
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.company.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column gradeDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Grade",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        vSizedBox1,
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.grade.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Column topColorDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Top Color",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
        ),
        vSizedBox1,
        Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.product.topcolor.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4C7088)),
            ),
          ),
        ),
      ],
    );
  }

  Container productDetailsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColorTextDark,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Text(
        widget.product.selectProduct.toString(),
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
