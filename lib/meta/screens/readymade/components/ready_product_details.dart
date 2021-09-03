import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/data/models/ready_made_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/common/widgets/svg_background.dart';
import 'package:inventory_management/meta/screens/readymade_order_submit/ready_made_order_submit_screen.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class ReadyProductDetails extends StatefulWidget {
  final ReadyMade readyMadeProduct;
  ReadyProductDetails({this.readyMadeProduct});

  @override
  _ReadyProductDetailsState createState() => _ReadyProductDetailsState();
}

class _ReadyProductDetailsState extends State<ReadyProductDetails> {
  @override
  void initState() {
    super.initState();
    _dashBoardController.loadSharedPrefs();
  }

  final DashBoardController _dashBoardController = Get.find();

  ///(DashBoardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // return SvgBackground(
    //   headerContent: Container(
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             BackButton(
    //               color: Colors.white,
    //             ),
    //             Spacer(
    //               flex: 2,
    //             ),
    //             Image.asset(
    //               "assets/images/text_logo2.png",
    //               fit: BoxFit.contain,
    //               width: MediaQuery.of(context).size.width * 0.15,
    //               height: MediaQuery.of(context).size.width * 0.15,
    //             ),
    //             Spacer(
    //               flex: 3,
    //             )
    //           ],
    //         ),
    //         Center(
    //           child: Text(
    //             "Product Details",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   content: Padding(
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: appBar(
          title: "Product Details",
          leadingWidget: BackButton(
            color: Colors.white,
          )),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: size.width / 40),
                            decoration: BoxDecoration(
                              color: Color(0xff2D3E4D),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              widget.readyMadeProduct.selectProduct.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 30,
                      ),
                      Expanded(
                          child: Text(
                        "Product Id : ${widget.readyMadeProduct.id}",
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: size.height / 80,
                  ),
                  Card(
                    elevation: 11,
                    shadowColor: Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/loading.gif",
                          image:
                              "https://d12oja0ew7x0i8.cloudfront.net/images/Article_Images/ImageForArticle_16788(1).jpg"),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ReadyMadeProuctContentTile(
                        containerColor: Colors.grey[300],
                        verticalPadding: 10,
                        horizontalPadding: size.width / 30,
                        lable: "Company",
                        value: widget.readyMadeProduct.company.toString(),
                      ),
                      Spacer(),
                      ReadyMadeProuctContentTile(
                        containerColor: Colors.grey[300],
                        verticalPadding: 10,
                        horizontalPadding: size.width / 30,
                        lable: "Grade",
                        value: widget.readyMadeProduct.grade.toString(),
                      ),
                      Spacer(),
                      ReadyMadeProuctContentTile(
                        containerColor: Colors.grey[300],
                        verticalPadding: 10,
                        horizontalPadding: size.width / 30,
                        lable: "TopColor",
                        value: widget.readyMadeProduct.topcolor.toString(),
                      ),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ReadyMadeProuctContentTile(
                          containerColor: Colors.grey[300],
                          lable: "Coating",
                          value: widget.readyMadeProduct.coating.toString(),
                          verticalPadding: 10,
                          horizontalPadding: size.width / 30,
                        ),
                      ),
                      Expanded(
                        child: ReadyMadeProuctContentTile(
                            containerColor: Colors.grey[300],
                            verticalPadding: 10,
                            horizontalPadding: size.width / 30,
                            lable: "Temper",
                            value: widget.readyMadeProduct.temper
                                .toString()
                                .toString()),
                      ),
                      Expanded(
                        child: ReadyMadeProuctContentTile(
                          containerColor: Colors.grey[300],
                          verticalPadding: 10,
                          horizontalPadding: size.width / 30,
                          lable: "G flim",
                          value: widget.readyMadeProduct.guardFilm.toString(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width / 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: kPrimaryColorLight),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ReadyMadeProuctContentTile(
                                  containerColor: productContainerColor,
                                  verticalPadding: 10,
                                  horizontalPadding: size.width / 90,
                                  lable: "Thikness",
                                  value: widget.readyMadeProduct.thickness
                                          .toStringAsFixed(2) +
                                      " mm",
                                ),
                              ),
                              SizedBox(
                                width: size.width / 30,
                              ),
                              Expanded(
                                child: ReadyMadeProuctContentTile(
                                    containerColor: productContainerColor,
                                    verticalPadding: 10,
                                    horizontalPadding: size.width / 90,
                                    lable: "Length",
                                    value: widget.readyMadeProduct.length
                                            .toStringAsFixed(2) +
                                        " mm"),
                              ),
                              SizedBox(
                                width: size.width / 30,
                              ),
                              Expanded(
                                child: ReadyMadeProuctContentTile(
                                  containerColor: productContainerColor,
                                  verticalPadding: 10,
                                  horizontalPadding: size.width / 90,
                                  lable: "Width",
                                  value: widget.readyMadeProduct.width
                                          .toStringAsFixed(2) +
                                      " mm",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              ReadyMadeProuctContentTile(
                                containerColor: productContainerColor,
                                verticalPadding: 10,
                                horizontalPadding: size.width / 30,
                                lable: "Pcs",
                                value: widget.readyMadeProduct.pcs.toString(),
                              ),
                              Spacer(),
                              ReadyMadeProuctContentTile(
                                  containerColor: productContainerColor,
                                  verticalPadding: 10,
                                  horizontalPadding: size.width / 30,
                                  lable: "Weight",
                                  value: widget.readyMadeProduct.weight
                                      .toString()
                                      .toString()),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                  Obx(
                    () => Visibility(
                        visible: _dashBoardController
                                    .userModel.value.data.role ==
                                "1" ||
                            _dashBoardController.userModel.value.data.role ==
                                "2",
                        child: OrderTextButton(
                          text: "Order",
                          onPressed: () {
                            Get.to(() => ReadyMadeOrderSubmitScreen(
                                product: widget.readyMadeProduct));
                          },
                        )),
                  ),
                  SizedBox(
                    height: size.height / 80,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class OrderTextButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  OrderTextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColorDark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300], blurRadius: 5, spreadRadius: 3)
              ]),
          height: 50,
          width: Get.width / 3,
          child: TextButton(
            child: Text(
              text,
              style: Constants.labelTextStyle
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

class ReadyMadeProuctContentTile extends StatelessWidget {
  final String lable;
  final String value;
  final double verticalPadding;
  final Color containerColor;
  final double horizontalPadding;

  ReadyMadeProuctContentTile(
      {this.lable,
      this.value,
      this.containerColor,
      this.verticalPadding,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              lable,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Center(
            child: Card(
              elevation: 11,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Container(
                height: 40,
                width: Get.size.width / 3.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColorDark),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
