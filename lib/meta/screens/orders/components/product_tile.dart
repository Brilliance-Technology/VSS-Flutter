import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/controllers/orders_controller.dart';
import 'package:inventory_management/app/controllers/product_tile_conroller.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/meta/screens/view_order/view_order.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProductTile extends StatefulWidget {
  final Re order;
  final int index;

  ProductTile({Key key, this.order, this.index}) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final ProductTileController _productTileController =
      Get.put(ProductTileController());
  final OrderController _orderController = Get.find();
  final DashBoardController _dashBoardController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Order Status: ${widget.order.orderStatus}");
    return Container(
      width: size.width,
      child: GestureDetector(
        onTap: () {
          print("Order Can EDIT");
          print(_orderController.isOderCanEdit(widget.order.createdOrderTime));
          print("product title presses");
          _orderController.currentOrder.value = widget.order;
          _orderController.currentOrderIndex.value = widget.index;
          Navigator.push(
            context,
            PageTransition(
              // duration: Duration(milliseconds: 500),
              child: ViewOrderScreen(
                  // order: widget.order,
                  ),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          margin: EdgeInsets.symmetric(
              horizontal: size.width / 30, vertical: size.width / 90),
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                color: Color(0xffE9EDEF),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text("OrderID. ${widget.order.orderId}"),
                        Spacer(),
                        Text("Date:${widget.order.orderDate}"),
                        SizedBox(
                          width: size.width / 50,
                        ),
                        Card(
                          elevation: 2,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: CircleAvatar(
                            radius: size.width * 0.015,
                            backgroundColor: _orderController
                                .getOrderStatusColor(widget.order.orderStatus),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Client',
                                    style: Constants.labelTextStyle
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'D. date',
                                    style: Constants.labelTextStyle
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    widget.order.clientName.toString(),
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    widget.order.deliveryDate.toString(),
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Text('PRODUCTS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )),
                      ),
                      Expanded(
                        child: Container(
                          // height: size.height / 90,
                          // width: size.width / 2,
                          child: widget.order.products.isNotEmpty
                              ? _productWidgetList()
                              : SizedBox(),
                        ),
                      ),
                      // widget.order.products.length > 1
                      //     ? Text(
                      //         "more..",
                      //         style: TextStyle(color: Colors.blue),
                      //       )
                      //: SizedBox(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      //   // crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 8, right: 8),
                      //       child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             primary: Colors.grey.shade600,
                      //             onPrimary: Colors.white,
                      //             onSurface: Colors.grey,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(8),
                      //             ),
                      //           ),
                      //           onPressed: () {},
                      //           child: Text(
                      //             'GCS',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           )),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 8, right: 8),
                      //       child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             primary: Colors.grey.shade600,
                      //             onPrimary: Colors.white,
                      //             onSurface: Colors.grey,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(8),
                      //             ),
                      //           ),
                      //           onPressed: () {},
                      //           child: Text(
                      //             'GCS',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           )),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 8, right: 0),
                      //       child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           primary: Colors.grey.shade600,
                      //           onPrimary: Colors.white,
                      //           onSurface: Colors.grey,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8),
                      //           ),
                      //         ),
                      //         onPressed: () {},
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 22, right: 22),
                      //           child: Text(
                      //             'View',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // Spacer(),
                      IconButton(
                        icon: Icon(Icons.expand_more),
                        onPressed: () {
                          widget.order.isProgressBarOn =
                              !widget.order.isProgressBarOn;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  widget.order.isProgressBarOn == true
                      ? Container(
                          width: size.width,
                          height: widget.order.products.length > 1
                              ? size.height / 4
                              : size.height / 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  // height: size.height / 90,
                                  // width: size.width / 2,
                                  child: widget.order.products.isNotEmpty
                                      ? widget.order.products.length > 1
                                          ? Wrap(
                                              alignment: WrapAlignment.start,
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                widget.order.products.length,
                                                (index) =>
                                                    index == 0 || index == 1
                                                        ? SizedBox()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    right: 4),
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          kPrimaryColorLight,
                                                                      onPrimary:
                                                                          Color(
                                                                              0xff394146),
                                                                      onSurface:
                                                                          kPrimaryColorLight,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      widget
                                                                          .order
                                                                          .products[
                                                                              index]
                                                                          .selectProduct
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    )),
                                                          ),
                                              ),
                                            )
                                          : SizedBox()
                                      : SizedBox()),
                              Container(
                                width: size.width / 1.2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    progressIndicatorContent(size, "S.M"),
                                    Spacer(),
                                    progressIndicatorContent(size, "P.M"),
                                    Spacer(
                                      flex: 4,
                                    ),
                                    progressIndicatorContent(size, "PIC"),
                                    Spacer(
                                      flex: 4,
                                    ),
                                    progressIndicatorContent(size, "D"),
                                    Spacer()
                                  ],
                                ),
                              ),
                              Container(
                                child: LinearPercentIndicator(
                                  width: size.width / 1.2,
                                  lineHeight: 8.0,
                                  percent: getProgresstrack(
                                      widget.order.orderStatus),
                                  progressColor: kPrimaryColorDark,
                                ),
                              ),
                              Spacer(
                                flex: 3,
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  _dashBoardController.userModel.value.data.role == "3"
                      ? Container(
                          child: Text(
                              "Remaining products : ${widget.order.products.where((element) => element.batchList.isEmpty).toList().length}"),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productWidgetList() {
    return Row(
      // alignment: WrapAlignment.start,
      // direction: Axis.horizontal,
      children: List.generate(
        widget.order.products.length > 1 ? 1 : widget.order.products.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8, right: 0),
          child: Container(
            // height: Get.size.width / 20,
            //width: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight,
                  onPrimary: Color(0xff394146),
                  onSurface: kPrimaryColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  widget.order.products[index].selectProduct.toString(),
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Container progressIndicatorContent(
    Size size,
    String text,
  ) {
    return Container(
      alignment: Alignment.centerRight,
      width: (size.width) * 0.192,
      child: Column(
        children: [Text(text), Icon(Icons.expand_more)],
      ),
    );
  }

  double getProgresstrack(int orderStatus) {
    switch (orderStatus) {
      case 0:
        return 0.2;
        break;
      case 1:
        return 0.42;
        break;
      case 2:
        return 0.85;
      case 3:
        return 1;
      default:
        return 0;
    }
  }
}
