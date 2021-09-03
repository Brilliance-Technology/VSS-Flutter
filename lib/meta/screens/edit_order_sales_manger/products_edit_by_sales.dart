import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/edit_order_by_sales_controller.dart';
import 'package:inventory_management/app/controllers/rate_controller.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/components/length_widget_sales.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/components/thickness_widget_sales.dart';
import 'package:inventory_management/meta/screens/edit_order_sales_manger/components/width_widget_sales.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class ProductEditBySales extends StatefulWidget {
  final Product product;
  final String orderId;
  final int index;
  ProductEditBySales({@required this.product, this.orderId, this.index});

  @override
  _ProductEditBySales createState() => _ProductEditBySales();
}

class _ProductEditBySales extends State<ProductEditBySales> {
  String selectedCompany;
  String selectedGrade;
  String selectedTopColor;
  final EditOrderBySalesController _editOrderBySalesController =
      Get.put(EditOrderBySalesController());
  TextEditingController _editRateController = TextEditingController();
  TextEditingController _gstController = TextEditingController();
  final RateController _rateGetXController = Get.put(RateController());
  int _pcs;
  double _weight;

  // calculateRateWithGST() {
  //   double rate = double.tryParse(_rateController.text) ?? 0.0;
  //   var rateWighGst = (rate) + (0.18 * rate);
  //   _rateController.text = rateWighGst.toString();
  //   print(rateWighGst);
  // }

  @override
  void initState() {
    _editOrderBySalesController.coating.value = widget.product.coatingnum;

    _editOrderBySalesController.temper.value = widget.product.temper.toString();

    _editOrderBySalesController.guard.value =
        widget.product.guardfilm.toString();
    _editOrderBySalesController.thickness.value = widget.product.thickness;
    _editOrderBySalesController.width.value = widget.product.width;
    _editOrderBySalesController.selectedLength.value = widget.product.length;
    selectedCompany = widget.product.company;
    selectedGrade = widget.product.grade;
    selectedTopColor = widget.product.topcolor;

    _pcs = widget.product.pcs;

    _weight = widget.product.weight;
    _rateGetXController.rateWithGST.value = widget.product.gst;
    _editRateController.text = widget.product.rate.toString();
    _gstController.text = widget.product.gst.toString();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: appBar(
        title: "Order Details",
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
                      topRight: Radius.circular(40))),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              // height: Get.size.height,
              padding: const EdgeInsets.only(
                top: 16,
                left: 24,
                right: 16,
              ),
              child: Card(
                color: Color(0xffECF0F4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productDetailsWidget(
                        widget.product.selectProduct.toString(),
                        // widget.orderId, widget.product.productId.toString()
                      ),
                      vSizedBox2,
                      availableWidget(widget.product.productId),
                      vSizedBox2,
                      Row(
                        /// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: companyDropDown()),
                          Expanded(child: gradeDropDown()),
                          Expanded(child: topColorDropDown()),
                        ],
                      ),
                      vSizedBox2,
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: coatingDropDown()),
                          Expanded(child: temperDropDown()),
                          Expanded(child: guardFilmDropDown()),
                        ],
                      ),
                      vSizedBox2,
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23)),
                        elevation: 5,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        color: kPrimaryColorLight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(child: ThicknessWidgetSales()),
                                  Expanded(child: LengthWidgetSales()),
                                  Expanded(child: WidthWidgetSales()),
                                ],
                              ),
                              pcsAndWeightRow(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSizedBox3,
                          vSizedBox3,
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rate (BASIC)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Container(
                                  width: Get.size.width / 3,
                                  child: Card(
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    elevation: 11,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _editRateController,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: kPrimaryColorDark),
                                        onChanged: (value) {
                                          _rateGetXController.rate.value =
                                              double.tryParse(value) ?? 0.0;

                                          _rateGetXController
                                                  .rateWithGST.value =
                                              (_rateGetXController.rate.value) +
                                                  (0.18 *
                                                      _rateGetXController
                                                          .rate.value);
                                        },
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          // labelText: "Rate",
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              )),
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: etHintColor,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 0,
                                          ),

                                          // hintText: 'Client Name',
                                        ),
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
                          Column(
                            children: [
                              Text(
                                "Rate (GST)",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              Container(
                                  width: Get.size.width / 3,
                                  child: Card(
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    elevation: 11,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Obx(
                                        () => Text(
                                          _rateGetXController.rateWithGST.value
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),

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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: keyboardIsOpened
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    label: Text("Update",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    icon: Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                    backgroundColor: kButtonColorPrimary,
                    onPressed: () {
                      _editOrderBySalesController
                          .selectedOrder.value.products[widget.index] = Product(
                        productId: widget.product.productId,
                        batchList: widget.product.batchList,
                        id: widget.product.id,
                        thickness: _editOrderBySalesController.thickness.value,
                        width: _editOrderBySalesController.width.value,
                        length:
                            _editOrderBySalesController.selectedLength.value,
                        coatingnum: _editOrderBySalesController.coating.value,
                        temper: _editOrderBySalesController.temper.value,
                        guardfilm: _editOrderBySalesController.guard.value,
                        company: selectedCompany,
                        grade: selectedGrade,
                        topcolor: selectedTopColor,
                        pcs: _pcs,
                        gst: _rateGetXController.rateWithGST.value,
                        rate: _rateGetXController.rate.value,
                        weight: _weight,
                        selectProduct: widget.product.selectProduct,
                      );
                      _editOrderBySalesController.selectedOrder.refresh();
                      Get.back();

                      Get.snackbar("Product ", "Product updated");

                      print(
                          "Thickness ${_editOrderBySalesController.thickness.toString()}");
                      print(
                          "Width ${_editOrderBySalesController.width.toString()}");
                      print(
                          "length ${_editOrderBySalesController.selectedLength.toString()}");
                      print(
                          "Coating ${_editOrderBySalesController.coating.value.toString()}");
                      print(
                          "Temper ${_editOrderBySalesController.temper.value.toString()}");
                      print(
                          "Guar ${_editOrderBySalesController.guard.value.toString()}");
                      print("Company ${selectedCompany.toString()}");
                      print("Grade ${selectedGrade.toString()}");
                      print("TopColor ${selectedTopColor.toString()}");
                      print("Pcs ${_pcs.toString()}");
                      // print("Rate ${rate.toString()}");
                      print("Weight ${_weight.toString()}");

                      // if (selectedCompany == null ||
                      //     selectedGrade == null ||
                      //     selectedTopColor == null ||
                      //     widget.product.coatingnum == null ||
                      // widget.product.temper== null ||
                      //     selectedGuard == null ||
                      //    _pcs ==null||
                      //     _weight==null ||
                      //     _rateController.text.isEmpty) {
                      //   showFlash(
                      //       context: context,
                      //       duration: Duration(seconds: 2),
                      //       builder: (context, controller) {
                      //         return Flash.dialog(
                      //           controller: controller,
                      //           borderRadius: const BorderRadius.all(
                      //               Radius.circular(8)),
                      //           backgroundColor: Colors.blue,
                      //           alignment: Alignment.bottomCenter,
                      //           margin:
                      //           const EdgeInsets.only(bottom: 120),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               'Please fill all the details',
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       });
                      // } else {
                      //   // addProductToCart(context);
                      //   showFlash(
                      //       context: context,
                      //       duration: Duration(seconds: 2),
                      //       builder: (context, controller) {
                      //         return Flash.dialog(
                      //           controller: controller,
                      //           borderRadius: const BorderRadius.all(
                      //               Radius.circular(8)),
                      //           backgroundColor: Colors.blue,
                      //           alignment: Alignment.bottomCenter,
                      //           margin:
                      //           const EdgeInsets.only(bottom: 120),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               'Product Added',
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       });

                      //}
                    },
                  ),
                  // model.isLoading
                  //     ? SizedBox(
                  //         width: 20,
                  //         height: 20,
                  //         child: CircularProgressIndicator(
                  //           strokeWidth: 2,
                  //           backgroundColor: Colors.white,
                  //         ),
                  //       )
                  //     : const SizedBox.shrink(),
                ],
              )),
    );
  }

  // Column widthColumn() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Text(
  //         "W",
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 6,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 24,
  //           vertical: 10,
  //         ),
  //         decoration: BoxDecoration(
  //           color: productContainerColor,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Text(
  //           "2:0",
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Column lengthColumn() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Text(
  //         "L",
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 6,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 24,
  //           vertical: 10,
  //         ),
  //         decoration: BoxDecoration(
  //           color: productContainerColor,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Text(
  //           "1:0",
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Column pcsColumn() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Text(
  //         "Pcs.",
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 6,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 24,
  //           vertical: 10,
  //         ),
  //         decoration: BoxDecoration(
  //           color: productContainerColor,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Text(
  //           "0:0",
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget pcsAndWeightRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSizedBox2,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pcs.",
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.5)),
              ),
              Container(
                child: Card(
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23)),
                  child: Container(
                    width: Get.size.width / 4,
                    height: 30,
                    //  padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.toString().contains(".")) {
                          return "Enter Number";
                        } else
                          return null;
                      },
                      initialValue: widget.product.pcs.toString(),
                      onChanged: (value) {
                        setState(() {
                          _pcs = int.tryParse(value);
                        });
                        print(_pcs);
                      },
                      style: TextStyle(
                        color: kPrimaryColorDark,
                        fontSize: 12,
                        // fontWeight: FontWeight.bold,
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        //fillColor: productContainerColor,
                        //filled: true,
                        labelText: "",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: kPrimaryColorDark)),
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
                ),
              ),
            ],
          ),
        ),
        hSizedBox2,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Weight",
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.5)),
              ),
              Container(
                child: Card(
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23)),
                  child: Container(
                    width: Get.size.width / 4,
                    height: 30,
                    // padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _weight = double.tryParse(value);
                        });
                      },
                      initialValue: widget.product.weight.toString(),
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: kPrimaryColorDark,
                        fontSize: 12,
                        // fontWeight: FontWeight.bold,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: productContainerColor,

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
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
                ),
              ),
            ],
          ),
        ),
        hSizedBox2,
      ],
    );
  }

  // Column weightColumn() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Text(
  //         "Weight",
  //         style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
  //       ),
  //       SizedBox(
  //         height: 6,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 24,
  //           vertical: 10,
  //         ),
  //         decoration: BoxDecoration(
  //           color: productContainerColor,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Text(
  //           "1:0",
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Column coatingDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Coating",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        Container(
          child: Card(
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 11,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              height: 30,
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Coating"),
                elevation: 0,
                underline: Text(""),
                style: TextStyle(
                  color: kPrimaryColorDark,
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                ),
                dropdownColor: Colors.white,
                value: _editOrderBySalesController.coating.value
                    .toString()
                    .toString(),
                onChanged: (newValue) {
                  setState(() {
                    _editOrderBySalesController.coating.value =
                        int.parse(newValue.toString());
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
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        Container(
          child: Card(
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 11,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              height: 30,
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Temper"),
                elevation: 0,
                underline: Text(""),
                style: TextStyle(
                  color: kPrimaryColorDark,
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                ),
                dropdownColor: Colors.grey.shade300,
                value: _editOrderBySalesController.temper.value.toString(),
                onChanged: (newValue) {
                  setState(() {
                    _editOrderBySalesController.temper.value =
                        newValue.toString();
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
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        Container(
          //width: Get.size.width / 3.5,
          //height: 30,

          child: Card(
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 11,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              height: 30,
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Guard"),
                elevation: 0,
                underline: Text(""),
                style: TextStyle(
                  color: kPrimaryColorDark,
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                ),
                dropdownColor: Colors.grey.shade300,
                value: _editOrderBySalesController.guard.value.toString(),
                onChanged: (newValue) {
                  setState(() {
                    _editOrderBySalesController.guard.value =
                        newValue.toString();
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
          ),
        )
      ],
    );
  }

  Widget companyDropDown() {
    return Column(
      children: [
        Text(
          "Company",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        Container(
            //width: Get.size.width / 3.5,
            //height: 30,

            child: Card(
          shadowColor: Colors.black.withOpacity(0.5),
          elevation: 11,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            height: 30,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(widget.product.company.toString()),
              elevation: 0,
              underline: Text(""),
              style: TextStyle(
                color: kPrimaryColorDark,
                fontSize: 12,
                // fontWeight: FontWeight.bold,
              ),
              value: selectedCompany,
              dropdownColor: Colors.grey.shade300,
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
        )),
      ],
    );
  }

  Column gradeDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Grade",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        Card(
          shadowColor: Colors.black.withOpacity(0.5),
          elevation: 11,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            width: Get.size.width / 3.5,
            height: 30,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(widget.product.grade),
              elevation: 0,
              underline: Text(""),
              style: TextStyle(
                color: kPrimaryColorDark,
                fontSize: 12,
                // fontWeight: FontWeight.bold,
              ),
              dropdownColor: Colors.grey.shade300,
              value: selectedGrade,
              onChanged: (newValue) {
                setState(() {
                  selectedGrade = newValue;
                });
              },
              items: Constants.grades.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
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
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        ),
        Card(
          shadowColor: Colors.black.withOpacity(0.5),
          elevation: 11,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Container(
            height: 30,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(widget.product.topcolor.toString()),
              elevation: 0,
              underline: Text(""),
              style: TextStyle(
                color: kPrimaryColorDark,
                fontSize: 12,
                // fontWeight: FontWeight.bold,
              ),
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
        ),
      ],
    );
  }

  Container weightWidget() {
    return Container(
      padding: const EdgeInsets.only(
        top: vBox1,
        left: hBox2,
      ),
      alignment: Alignment.topLeft,
      child: Text(
        "Weight",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget availableWidget(String productId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PRODUCT ID:  $productId",
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

  Widget productDetailsWidget(String productName) {
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
//   }
//   Row productDetailsWidget(
//       String productName, String orderID, String productId) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 10,
//           ),
//           decoration: BoxDecoration(
//             color: productContainerColor,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             productName,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         hSizedBox2,
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "ORDER ID:  $orderID",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//               vSizedBox1,
//               Text(
//                 "PRODUCT ID:  $productId}",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
