import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/rate_controller.dart';
import 'package:inventory_management/app/controllers/value_converter_controller.dart';

import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/meta/screens/all_products_list/all_products_list.dart';

import 'package:inventory_management/meta/widgets/app_bar.dart';
import 'package:inventory_management/provider/cart_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  final String productName;

  const OrderDetails(
      {Key key, @required this.orderId, @required this.productName})
      : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool _toggle = false;
  String selectedCompany = Constants.companies.first;
  String selectedGrade = Constants.grades.first;
  String selectedTopColor = Constants.topColors.first;
  String selectedCoating = Constants.coatings.first;
  String selectedTemper = Constants.tempers.first;
  String selectedGuard = Constants.guardFilms.first;
  final RateController _rateGetXController = Get.put(RateController());
  // static const double _rate = 0.0;
  // TextEditingController _rateController =
  //     TextEditingController(text: _rate.toString());
  // TextEditingController _gstRateController;
  // double rate = _rate;

  TextEditingController _pcsController = TextEditingController(text: "");
  TextEditingController _weightController = TextEditingController(text: "");

  // calculateRateWithGST() {
  //   double rate = double.tryParse(_rateController.text) ?? 0.0;
  //   var rateWighGst = (rate) + (0.18 * rate);
  //   _rateController.text = rateWighGst.toString();
  //   print(rateWighGst);
  // }

  Future<void> addProductToCart(BuildContext context) async {
    var model = Provider.of<CartProvider>(context, listen: false);
    String productId =
        "${widget.orderId}/${widget.productName.toLowerCase()}/${model.productsLength + 1}";
    Product product = Product(
        productId: productId,
        selectProduct: widget.productName,
        company: selectedCompany,
        grade: selectedGrade,
        topcolor: selectedTopColor,
        coatingnum: int.tryParse(selectedCoating),
        temper: selectedTemper,
        guardfilm: selectedGuard,
        thickness: model.thickness,
        length: model.length,
        width: model.width,
        pcs: int.tryParse(_pcsController.text.replaceAll(",", "")),
        weight: double.tryParse(_weightController.text.replaceAll(",", "")),
        rate: _rateGetXController.rate.value,
        gst: _rateGetXController.rateWithGST.value,
        isOrderReady: _toggle);
    int len = model.products
        .where((element) =>
            element.pcs == product.pcs &&
            element.length == product.length &&
            element.thickness == product.thickness &&
            element.width == product.width)
        .toList()
        .length;
    if (len > 0) {
      Get.dialog(
          Dialog(
            child: Container(
              height: Get.size.height / 3,
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    "Product",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "Product already in cart do you want add?\n with this Length, width, Thickness",
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await model.addProductToCart(product, context);
                          Get.back();
                          showFlash(
                              context: context,
                              duration: Duration(seconds: 2),
                              builder: (context, controller) {
                                return Flash.dialog(
                                  controller: controller,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  backgroundColor: Colors.blue,
                                  alignment: Alignment.bottomCenter,
                                  margin: const EdgeInsets.only(bottom: 120),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Product Added',
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
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          barrierDismissible: false);
    } else {
      await model.addProductToCart(product, context);
      showFlash(
          context: context,
          duration: Duration(seconds: 2),
          builder: (context, controller) {
            return Flash.dialog(
              controller: controller,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              backgroundColor: kPrimaryColorDark,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 120),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Product Added',
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
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Consumer<CartProvider>(
        builder: (context, model, child) => Scaffold(
              appBar: appBar(
                title: "Order Details",
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
                        model.productsLength.toString(),
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
                              type: PageTransitionType.topToBottom,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: kPrimaryColorDark,
              body: SingleChildScrollView(
                child: Container(
                  // height: Get.size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 24,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Date  : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            model.currentOrder.currentDate,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Text(
                        "ORDER ID:  ${widget.orderId}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: Get.size.height / 30,
                      ),
                      Card(
                        margin: EdgeInsets.all(0),
                        color: Color(0xffF2F2F2),
                        elevation: 11,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              productDetailsWidget(
                                  widget.productName, model.productsLength),
                              vSizedBox2,
                              availableWidget(widget.productName,
                                  widget.orderId, model.productsLength),
                              // weightWidget(),
                              vSizedBox2,
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child:
                                              CustomProductDescriptionDropDown(
                                            hintText: "Company",
                                            dropdownItems: Constants.companies,
                                            selectedGrade:
                                                Constants.companies[0],
                                            onChange: (newValue) {
                                              setState(() {
                                                selectedCompany = newValue;
                                              });
                                      print(newValue);    
                                            },  
                                            value: selectedCompany,
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                              CustomProductDescriptionDropDown(
                                            hintText: "Grades",
                                            dropdownItems: Constants.grades,
                                            selectedGrade: Constants.grades[0],
                                            value: selectedGrade,
                                            onChange: (newValue) {
                                              setState(() {
                                                selectedGrade = newValue;
                                              });
                                              print(newValue);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                              CustomProductDescriptionDropDown(
                                            hintText: "Top Color",
                                            dropdownItems: Constants.topColors,
                                            selectedGrade:
                                                Constants.topColors[0],
                                            value: selectedTopColor,
                                            onChange: (newValue) {
                                              setState(() {
                                                selectedTopColor = newValue;
                                              });
                                              print(newValue);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    vSizedBox2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child:
                                              CustomProductDescriptionDropDown(
                                            hintText: "Coating",
                                            dropdownItems: Constants.coatings,
                                            selectedGrade:
                                                Constants.coatings[0],
                                            value: selectedCoating,
                                            onChange: (newValue) {
                                              setState(() {
                                                selectedCoating = newValue;
                                              });
                                              print(newValue);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                              CustomProductDescriptionDropDown(
                                            hintText: "Temper",
                                            dropdownItems: Constants.tempers,
                                            selectedGrade: Constants.tempers[0],
                                            value: selectedTemper,
                                            onChange: (newValue) {
                                              setState(() {
                                                selectedTemper = newValue;
                                              });
                                              print(newValue);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                              CustomProductDescriptionDropDown(
                                            hintText: "Guards",
                                            dropdownItems: Constants.guardFilms,
                                            selectedGrade:
                                                Constants.guardFilms[0],
                                            value: selectedGuard,
                                            onChange: (newValue) {
                                              setState(() {
                                                selectedGuard = newValue;
                                              });
                                              print(newValue);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    vSizedBox2,
                                    Container(
                                      child: Card(
                                        elevation: 11,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(23)),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                              color: kPrimaryColorLight),
                                          child: Wrap(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                width: Get.size.width,
                                                child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  alignment:
                                                      WrapAlignment.spaceAround,
                                                  children: [
                                                    // Spacer(),
                                                    ThicknessWidget(),

                                                    LengthWidget(),

                                                    WidthWidget(),
                                                    // Spacer()
                                                  ],
                                                ),
                                              ),
                                              vSizedBox2,
                                              pcsAndWeightRow(),
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                              )
                                              // Container(
                                              // decoration: BoxDecoration(
                                              //   borderRadius:
                                              //       BorderRadius.circular(
                                              //           10),
                                              //   color: bgEditText,
                                              // ),
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 10),
                                              // width: MediaQuery.of(context)
                                              //     .size
                                              //     .width,
                                              // child:
                                              // Row(
                                              //   children: [
                                              //     // Radio(
                                              //     //     groupValue: [true, false],
                                              //     //     toggleable: true,
                                              //     //     value: _toggle,
                                              //     //     onChanged: (value) {
                                              //     //       setState(() {
                                              //     //         _toggle = value;
                                              //     //       });
                                              //     //     }),
                                              //     // Text("Ready"),
                                              //   ],
                                              // )
                                              // ),
                                              // SizedBox(
                                              //   height: 30,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Rate (BASIC)",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.7)),
                                              ),
                                              Container(
                                                width: Get.size.width / 3.5,
                                                height: 40,
                                                child: Card(
                                                  shadowColor: Colors.black
                                                      .withOpacity(0.5),
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              23)),
                                                  child: TextField(
                                                    //controller: _rateController,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: kPrimaryColorDark,
                                                    ),
                                                    onChanged: (value) {
                                                      _rateGetXController
                                                              .rate.value =
                                                          double.tryParse(value
                                                                  .replaceAll(
                                                                      ",",
                                                                      "")) ??
                                                              0.0;

                                                      _rateGetXController
                                                              .rateWithGST
                                                              .value =
                                                          (_rateGetXController
                                                                  .rate.value) +
                                                              (0.18 *
                                                                  _rateGetXController
                                                                      .rate
                                                                      .value);
                                                    },
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(23),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      //  labelText: "Rate",
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          23),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kPrimaryColorDark)),
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
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Column(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Rate (GST)",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                ),
                                              ),
                                              Card(
                                                shadowColor: Colors.black
                                                    .withOpacity(0.5),
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Container(
                                                  width: Get.size.width / 3.5,
                                                  alignment: Alignment.center,
                                                  //height: 30,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Obx(
                                                    () => Text(
                                                      _rateGetXController
                                                          .rateWithGST.value
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            kPrimaryColorDark,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Card(
                                              //   shape: RoundedRectangleBorder(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               23)),
                                              //   child: Container(
                                              //    s
                                              //     width: Get.width,
                                              //     height: 40,
                                              //     //controller: _gstRateController,

                                              //     child: Obx(
                                              //       () => Text(
                                              //         _rateGetXController
                                              //             .rateWithGST.value
                                              //             .toString(),
                                              //       ),
                                              //     ),

                                              //     // textInputAction: TextInputAction.done,
                                              //     // keyboardType:
                                              //     //     TextInputType.numberWithOptions(
                                              //     //         decimal: true),
                                              //     decoration: BoxDecoration(
                                              //       color: bgEditText,
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               //       borderRadius:
                                              //               10
                                              //               //borderSide: BorderSide.none,
                                              //               ),

                                              //       //double.tryParse(_rateController.text.replaceAll(",", "")

                                              //       // filled: true,
                                              //       //enabled: false,
                                              //       // labelText: "Rate",
                                              //       // focusedBorder: OutlineInputBorder(
                                              //       //     borderRadius:
                                              //       //         BorderRadius.circular(10),
                                              //       //     borderSide: BorderSide(
                                              //       //       color: Colors.blue,
                                              //       //     )),
                                              //       // hintStyle: TextStyle(
                                              //       //   fontWeight: FontWeight.w500,
                                              //       //   color: etHintColor,
                                              //       // ),
                                              //       // contentPadding:
                                              //       //     const EdgeInsets.symmetric(
                                              //       //   horizontal: 16,
                                              //       //   vertical: 0,
                                              //       // ),

                                              //       // hintText: 'Client Name',
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // Column(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   crossAxisAlignment: CrossAxisAlignment.center,
                                        //   children: [
                                        //     Transform.scale(
                                        //       scale: 1.1,
                                        //       child: Switch(
                                        //         value: gstEnabled,
                                        //         onChanged: (newValue) {
                                        //           setState(() {
                                        //             gstEnabled = newValue;
                                        //             if (gstEnabled) {
                                        //               calculateRateWithGST();
                                        //             }
                                        //           });
                                        //         },
                                        //         activeColor: Colors.blue,
                                        //         inactiveThumbColor: Colors.white,
                                        //         inactiveTrackColor:
                                        //             Colors.grey.shade600,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       "GST%",
                                        //       style: TextStyle(
                                        //         fontSize: 12,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // FloatingActionButton(
                                        //   backgroundColor: Colors.grey.shade600,
                                        //   onPressed: () {
                                        //     addProductToCart();
                                        //   },
                                        //   child: Icon(
                                        //     Icons.add,
                                        //     color: Colors.white,
                                        //   ),
                                        //   mini: true,
                                        // ),

                                        IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              size: 30,
                                              color: kPrimaryTextColor,
                                            ),
                                            onPressed: () {
                                              print(model.thickness);
                                              if (selectedCompany == null ||
                                                  selectedGrade == null ||
                                                  selectedTopColor == null ||
                                                  selectedCoating == null ||
                                                  selectedTemper == null ||
                                                  selectedGuard == null ||
                                                  _pcsController.text == "0" ||
                                                  _pcsController.text == "" ||
                                                  model.thickness == 0.0 ||
                                                  model.length == 0.0 ||
                                                  model.width == 0.0 ||
                                                  _rateGetXController
                                                          .rate.value ==
                                                      0.0 ||
                                                  _weightController.text ==
                                                      "" ||
                                                  _weightController.text ==
                                                      "0") {
                                                showFlash(
                                                    context: context,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    builder:
                                                        (context, controller) {
                                                      return Flash.dialog(
                                                        controller: controller,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    8)),
                                                        backgroundColor:
                                                            kPrimaryColorTextDark,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        margin: const EdgeInsets
                                                            .only(bottom: 120),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Please fill all the details',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              } else {
                                                addProductToCart(context);
                                              }
                                            })
                                      ],
                                    ),
                                    vSizedBox4,
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // floatingActionButton: keyboardIsOpened
              //     ? null
              //     : Padding(
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 16, horizontal: 8),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             FloatingActionButton.extended(
              //                 label: Text("Add",
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                     )),
              //                 icon: Icon(
              //                   Icons.add,
              //                   color: Colors.white,
              //                 ),
              //                 backgroundColor: Colors.grey.shade800,
              //                 onPressed: () {}),
              //             model.isLoading
              //                 ? SizedBox(
              //                     width: 20,
              //                     height: 20,
              //                     child: CircularProgressIndicator(
              //                       strokeWidth: 2,
              //                       backgroundColor: Colors.white,
              //                     ),
              //                   )
              //                 : const SizedBox.shrink(),
              //           ],
              //         )),
            ));
  }

  Row chartInformation() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clint Name',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Firm',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Rate/kg',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Delivery D',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Order ID',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Product ID',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
            flex: 2,
            child: Container(
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alkesh Patil',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'Brilliance Technology',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      '670 kgs ',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      '23 - 3 - 21',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'BH368DV',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'HUDF674',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      'Mars dis - Galactial Space',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  Column widthColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "W",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: productContainerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "2:0",
            style: TextStyle(
              fontWeight: FontWeight.bold,
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
          "L",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: productContainerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "1:0",
            style: TextStyle(
              fontWeight: FontWeight.bold,
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: productContainerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "0:0",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget pcsAndWeightRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSizedBox2,
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              "Pcs.",
              style:
                  TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.7)),
            ),
            Card(
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                child: Container(
                  width: Get.size.width / 3.5,
                  height: 30,
                  child: TextField(
                    controller: _pcsController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Color(0xff4C7088), fontSize: 10),
                    decoration: InputDecoration(
                      //labelText: "Pcs",
                      //labelStyle: TextStyle(color: kPrimaryColorDark, fontSize: 12),
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: kPrimaryColorDark,
                          )),

                      hintStyle: TextStyle(
                        color: kPrimaryColorDark,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),

                      // hintText: 'Client Name',
                    ),
                  ),
                ))
          ]),
        ),
        hSizedBox2,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Weight",
                style: TextStyle(
                    fontSize: 10, color: Colors.black.withOpacity(0.7)),
              ),
              Card(
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                child: Container(
                  width: Get.size.width / 3.5,
                  height: 30,
                  child: TextField(
                    style: TextStyle(color: Color(0xff4C7088), fontSize: 10),
                    controller: _weightController,
                    textInputAction: TextInputAction.done,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      // labelText: "Weight",
                      hintText: '0.0',
                      labelStyle:
                          TextStyle(color: kPrimaryColorDark, fontSize: 12),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: kPrimaryColorDark)),
                      hintStyle: TextStyle(
                          //fontWeight: FontWeight.w500,
                          color: kPrimaryColorDark,
                          fontSize: 10),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 0,
                      ),

                      // hintText: 'Client Name',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _toggle = !_toggle;
              });
            },
            child: Container(
              height: 20,
              width: 20,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: _toggle == true
                      ? CircleAvatar(
                          backgroundColor: kPrimaryColorDark,
                        )
                      : SizedBox()),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: kPrimaryColorDark),
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
        ),

        // Radio(
        //     splashRadius: 10,
        //     groupValue: [true, false],
        //     toggleable: true,
        //     value: _toggle,
        //     onChanged: (value) {
        //       setState(() {
        //         _toggle = value;
        //       });
        //     }),
        Text(
          "Ready",
          style: TextStyle(fontSize: 12),
        ),
        hSizedBox2,
      ],
    );
  }

  Column weightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weight",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: productContainerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "1:0",
            style: TextStyle(
              color: Color(0xff4C7088),
              fontWeight: FontWeight.bold,
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        vSizedBox1,
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: bgEditText,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            isExpanded: false,
            hint: Text("Coating"),
            elevation: 0,
            underline: Text(""),
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Monteserat",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            iconSize: 0,
            // icon: Icon(null),
            dropdownColor: Colors.grey.shade300,

            value: selectedCoating,
            onChanged: (newValue) {
              setState(() {
                selectedCoating = newValue;
              });
            },
            items: Constants.coatings.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        vSizedBox1,
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: bgEditText,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            isExpanded: false,
            hint: Text("Temper"),
            elevation: 0,
            underline: Text(""),
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Monteserat",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            iconSize: 0,
            // icon: Icon(null),
            dropdownColor: Colors.grey.shade300,

            value: selectedTemper,
            onChanged: (newValue) {
              setState(() {
                selectedTemper = newValue;
              });
            },
            items: Constants.tempers.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        vSizedBox1,
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: bgEditText,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            isExpanded: false,
            hint: Text("Guard"),
            elevation: 0,
            underline: Text(""),
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Monteserat",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            iconSize: 0,
            // icon: Icon(null),
            dropdownColor: Colors.grey.shade300,

            value: selectedGuard,
            onChanged: (newValue) {
              setState(() {
                selectedGuard = newValue;
              });
            },
            items: Constants.guardFilms.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column companyDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        vSizedBox1,
        Card(
          // padding: const EdgeInsets.only(left: 8, right: 8),
          // decoration: BoxDecoration(
          //   color: bgEditText,
          //   borderRadius: BorderRadius.circular(10),
          // ),
          elevation: 11,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: DropdownButton(
            disabledHint: Text("Company"),

            hint: Padding(
                padding: EdgeInsets.only(left: 10), child: Text("Company")),
            elevation: 11,
            underline: SizedBox(),
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Monteserat",
                fontWeight: FontWeight.bold,
                color: kPrimaryColorDark),

            // icon: Icon(null),
            value: selectedCompany,
            dropdownColor: Colors.white,
            onChanged: (newValue) {
              setState(() {
                selectedCompany = newValue;
              });
            },
            items: Constants.companies.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Widget gradeDropDown() {
  //   return
  // }

  Column topColorDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Top Color",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        vSizedBox1,
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: bgEditText,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            isExpanded: false,
            hint: Text("Top Color"),
            elevation: 0,
            underline: Text(""),
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Monteserat",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            iconSize: 0,
            // icon: Icon(null),
            value: selectedTopColor,
            dropdownColor: Colors.grey.shade300,

            onChanged: (newValue) {
              setState(() {
                selectedTopColor = newValue;
              });
            },
            items: Constants.topColors.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Container weightWidget() {
  //   return Container(
  //     padding: const EdgeInsets.only(
  //       top: vBox1,
  //       left: hBox2,
  //     ),
  //     alignment: Alignment.topLeft,
  //     child: Text(
  //       "Weight",
  //       style: TextStyle(
  //         fontSize: 10,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

  Column availableWidget(
      String productName, String orderID, int productsLength) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PRODUCT ID:  $orderID/${productName.toLowerCase()}/${productsLength + 1}",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
            hSizedBox1,
            Text(
              "Weight",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "140 tons",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget productDetailsWidget(String productName, int productsLength) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      elevation: 11,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: kPrimaryTextColor,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Text(
          productName,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CalculateDialog extends StatelessWidget {
  // var feetController = TextEditingController(text: "0.0");
  // var inchesController = TextEditingController(text: "0.0");

  final feet = 0.0;
  final inch = 0.0;

  final ValueConverterController _converterController =
      Get.put(ValueConverterController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 11,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: Get.size.height / 3,
        width: Get.size.width / 1.5,
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      "Converter",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: kButtonColorPrimary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            vSizedBox1,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "FEET",
                        style: TextStyle(
                          fontSize: 12,
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSizedBox1,
                      Card(
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value != null) {
                              if (value.toString() == "") {
                                _converterController.feetToMM(0);
                              } else {
                                _converterController
                                    .feetToMM(double.parse(value));
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "0.00",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            // labelText: "FEET",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: kPrimaryColorDark,
                                )),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: etHintColor,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),

                            // hintText: 'Client Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "INCH",
                        style: TextStyle(
                          fontSize: 12,
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSizedBox1,
                      Card(
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value != null) {
                              if (value.toString() == "") {
                                _converterController.inchesToMM(0.0);
                              } else {
                                _converterController
                                    .inchesToMM(double.parse(value.toString()));
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "0.00",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            // labelText: "INCH",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: kPrimaryColorDark,
                                )),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: etHintColor,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),

                            // hintText: 'Client Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      "=",
                      style: TextStyle(
                        color: kPrimaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MM",
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSizedBox1,
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => Text(
                              (_converterController.incheToMM.value +
                                      _converterController
                                          .totalInchesToMM.value)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                // alignment: Alignment.topRight,
                padding: const EdgeInsets.only(
                  // right: 10,
                  top: 20,
                ),
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
                    Navigator.pop(
                        context,
                        (_converterController.incheToMM.value +
                                _converterController.totalInchesToMM.value)
                            .toStringAsFixed(2));
                    _converterController.incheToMM.value = 0.0;
                    _converterController.totalInchesToMM.value = 0.0;
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
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

class ThicknessWidget extends StatefulWidget {
  @override
  _ThicknessWidgetState createState() => _ThicknessWidgetState();
}

class _ThicknessWidgetState extends State<ThicknessWidget> {
  var thickness = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Thickness",
          style: TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.7)

              //fontWeight: FontWeight.bold,
              ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CalculateDialog();
                }).then((value) {
              setState(() {
                thickness = double.tryParse(value) ?? 0;
                Provider.of<CartProvider>(context, listen: false)
                    .setThickness(thickness);
                print("Thickness is $thickness");
              });
            });
          },
          child: Card(
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              width: Get.size.width / 5,
              alignment: Alignment.center,
              //height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                thickness.toString() + " " + "mm",
                style: TextStyle(color: Color(0xff4C7088), fontSize: 10

                    //fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LengthWidget extends StatefulWidget {
  @override
  _LengthWidgetState createState() => _LengthWidgetState();
}

class _LengthWidgetState extends State<LengthWidget> {
  var length = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Length",
          style: TextStyle(
            fontSize: 10,
            color: Colors.black.withOpacity(0.7),
            //  fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CalculateDialog();
                }).then((value) {
              setState(() {
                length = double.tryParse(value) ?? 0;
                Provider.of<CartProvider>(context, listen: false)
                    .setLength(length);

                print("Length is $length");
              });
            });
          },
          child: Card(
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              width: Get.size.width / 5,
              alignment: Alignment.center,
              //height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                length.toString() + " " + "mm",
                style: TextStyle(color: kPrimaryColorDark, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WidthWidget extends StatefulWidget {
  @override
  _WidthWidgetState createState() => _WidthWidgetState();
}

class _WidthWidgetState extends State<WidthWidget> {
  var width = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Width",
          style: TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.7)),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CalculateDialog();
                }).then((value) {
              setState(() {
                width = double.tryParse(value) ?? 0;
                Provider.of<CartProvider>(context, listen: false)
                    .setWidth(width);
                print("Width is $width");
              });
            });
          },
          child: Card(
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              width: Get.size.width / 5,
              alignment: Alignment.center,
              //height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                width.toStringAsFixed(1) + " " + "mm",
                style: TextStyle(
                  fontSize: 10,
                  color: kPrimaryColorDark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomProductDescriptionDropDown extends StatefulWidget {
  final String hintText;
  String selectedGrade;
  final Function onChange;
  final String value;
  final List<String> dropdownItems;
  CustomProductDescriptionDropDown(
      {this.hintText,
      this.selectedGrade,
      this.dropdownItems,
      this.onChange,
      this.value});

  @override
  _CustomProductDescriptionDropDownState createState() =>
      _CustomProductDescriptionDropDownState();
}

class _CustomProductDescriptionDropDownState
    extends State<CustomProductDescriptionDropDown> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // padding: const EdgeInsets.only(left: 8, right: 8),
      // decoration: BoxDecoration(
      //   color: bgEditText,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 11,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Container(
        width: Get.size.width / 3.5,
        height: 30,
        padding: const EdgeInsets.only(left: 12, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton(
          isExpanded: true,
          hint: Text(widget.hintText),
          elevation: 5,
          underline: Text(""),
          style: TextStyle(
            fontSize: 10,
            fontFamily: "Monteserat",
            fontWeight: FontWeight.bold,
            color: Color(0xff4C7088),
          ),
          dropdownColor: Colors.white,
          value: widget.value,
          onChanged: widget.onChange,
          items: widget.dropdownItems.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
