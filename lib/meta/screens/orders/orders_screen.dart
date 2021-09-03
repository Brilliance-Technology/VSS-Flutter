import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/conectivity_tester.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/controllers/orders_controller.dart';
import 'package:inventory_management/meta/screens/create_order_screen/create_order_screen.dart';
import 'package:inventory_management/meta/screens/orders/components/product_tile.dart';
import 'package:page_transition/page_transition.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderController _orderController = Get.put(OrderController());

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final ConnectivityTester connectivityTester = Get.put(ConnectivityTester());

  final DashBoardController _dashBoardController = Get.find();

  final snackBar = SnackBar(content: Text('New content loaded'));
  @override
  void initState() {
    super.initState();
    _orderController.getAllOrders(
        1, 10, _orderController.orderStatusValue.value);
    _orderController.orderListView();

  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<OrderProvider>(builder: (context, model, child) {
    // var orders = model.ordersList;
    final size = MediaQuery.of(context).size;

    return Container(
      // height: size.height,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: size.width / 70),
            child: Obx(
              () => _orderController.isLoading.value == true &&
                      _orderController.isLoadingForDate.value == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Obx(
                      () => _orderController.orderList.toList().isEmpty
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No Orders found",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                        onPressed: () => onRefresh(),
                                        child: Text(
                                          "Refresh",
                                          style: TextStyle(color: Colors.blue),
                                        ))
                                  ]),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       // color: Colors.red,
                                //       borderRadius: BorderRadius.only(
                                //           topRight: Radius.circular(30),
                                //           topLeft: Radius.circular(30)),
                                //     ),
                                //     child: Obx(
                                //       () => _dashBoardController
                                //                       .userModel.value.data.role ==
                                //                   "1" ||
                                //               _dashBoardController
                                //                       .userModel.value.data.role ==
                                //                   "2"
                                //           ? Row(
                                //               children: [
                                //                 Container(
                                //                   width: size.width / 4,
                                //                   child: Padding(
                                //                     padding: EdgeInsets.all(10),
                                //                     child: ChoiceChip(
                                //                       label: Text("All"),
                                //                       selected: _orderController
                                //                               .orderStatusValue
                                //                               .value ==
                                //                           4,
                                //                       selectedColor: Colors.blue,
                                //                       onSelected: (bool selected) {
                                //                         _orderController
                                //                             .orderStatusValue
                                //                             .value = 4;
                                //                       },
                                //                       backgroundColor: Colors.grey,
                                //                       labelStyle: TextStyle(
                                //                           color: Colors.white),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   width: size.width / 3,
                                //                   child: Padding(
                                //                     padding: EdgeInsets.symmetric(
                                //                         horizontal: 10),
                                //                     child: ChoiceChip(
                                //                       label: Text("Delivered"),
                                //                       selected: _orderController
                                //                               .orderStatusValue
                                //                               .value ==
                                //                           3,
                                //                       selectedColor: Colors.blue,
                                //                       onSelected: (bool selected) {
                                //                         _orderController
                                //                             .orderStatusValue
                                //                             .value = 3;

                                //                         print(
                                //                             "Oder Statues Curent :" +
                                //                                 _orderController
                                //                                     .orderStatusValue
                                //                                     .value
                                //                                     .toString());
                                //                       },
                                //                       backgroundColor: Colors.grey,
                                //                       labelStyle: TextStyle(
                                //                           color: Colors.white),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   width: size.width / 3,
                                //                   child: Padding(
                                //                     padding: EdgeInsets.all(10),
                                //                     child: ChoiceChip(
                                //                       label: Text("Accepted"),
                                //                       selected: _orderController
                                //                               .orderStatusValue
                                //                               .value ==
                                //                           1,
                                //                       selectedColor: Colors.blue,
                                //                       onSelected: (bool selected) {
                                //                         _orderController
                                //                             .orderStatusValue
                                //                             .value = 1;
                                //                       },
                                //                       backgroundColor: Colors.grey,
                                //                       labelStyle: TextStyle(
                                //                           color: Colors.white),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   width: size.width / 3,
                                //                   child: Padding(
                                //                     padding: EdgeInsets.all(10),
                                //                     child: ChoiceChip(
                                //                       label: Text("Pending"),
                                //                       selected: _orderController
                                //                               .orderStatusValue
                                //                               .value ==
                                //                           0,
                                //                       selectedColor: Colors.blue,
                                //                       onSelected: (bool selected) {
                                //                         _orderController
                                //                             .orderStatusValue
                                //                             .value = 0;
                                //                       },
                                //                       backgroundColor: Colors.grey,
                                //                       labelStyle: TextStyle(
                                //                           color: Colors.white),
                                //                     ),
                                //                   ),
                                //                 )
                                //               ],
                                //             )
                                //           : _dashBoardController
                                //                       .userModel.value.data.role ==
                                //                   "4"
                                //               ? Row(
                                //                   children: [
                                //                     Container(
                                //                       width: size.width / 4,
                                //                       child: Padding(
                                //                         padding: EdgeInsets.all(10),
                                //                         child: ChoiceChip(
                                //                           label: Text("All"),
                                //                           selected: _orderController
                                //                                   .orderStatusValue
                                //                                   .value ==
                                //                               4,
                                //                           selectedColor:
                                //                               Colors.blue,
                                //                           onSelected:
                                //                               (bool selected) {
                                //                             _orderController
                                //                                 .orderStatusValue
                                //                                 .value = 4;
                                //                           },
                                //                           backgroundColor:
                                //                               Colors.grey,
                                //                           labelStyle: TextStyle(
                                //                               color: Colors.white),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Container(
                                //                       width: size.width / 3,
                                //                       child: Padding(
                                //                         padding:
                                //                             EdgeInsets.symmetric(
                                //                                 horizontal: 10),
                                //                         child: ChoiceChip(
                                //                           label: Text("Incomplete"),
                                //                           selected: _orderController
                                //                                   .orderStatusValue
                                //                                   .value ==
                                //                               2,
                                //                           selectedColor:
                                //                               Colors.blue,
                                //                           onSelected:
                                //                               (bool selected) {
                                //                             _orderController
                                //                                 .orderStatusValue
                                //                                 .value = 2;

                                //                             print("Oder Statues Curent :" +
                                //                                 _orderController
                                //                                     .orderStatusValue
                                //                                     .value
                                //                                     .toString());
                                //                           },
                                //                           backgroundColor:
                                //                               Colors.grey,
                                //                           labelStyle: TextStyle(
                                //                               color: Colors.white),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Container(
                                //                       width: size.width / 3,
                                //                       child: Padding(
                                //                         padding: EdgeInsets.all(10),
                                //                         child: ChoiceChip(
                                //                           label: Text("Delivered"),
                                //                           selected: _orderController
                                //                                   .orderStatusValue
                                //                                   .value ==
                                //                               3,
                                //                           selectedColor:
                                //                               Colors.blue,
                                //                           onSelected:
                                //                               (bool selected) {
                                //                             _orderController
                                //                                 .orderStatusValue
                                //                                 .value = 3;
                                //                           },
                                //                           backgroundColor:
                                //                               Colors.grey,
                                //                           labelStyle: TextStyle(
                                //                               color: Colors.white),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 )
                                //               : Row(
                                //                   children: [
                                //                     Container(
                                //                       width: size.width / 4,
                                //                       child: Padding(
                                //                         padding: EdgeInsets.all(10),
                                //                         child: ChoiceChip(
                                //                           label: Text("All"),
                                //                           selected: _orderController
                                //                                   .orderStatusValue
                                //                                   .value ==
                                //                               4,
                                //                           selectedColor:
                                //                               Colors.blue,
                                //                           onSelected:
                                //                               (bool selected) {
                                //                             _orderController
                                //                                 .orderStatusValue
                                //                                 .value = 4;
                                //                           },
                                //                           backgroundColor:
                                //                               Colors.grey,
                                //                           labelStyle: TextStyle(
                                //                               color: Colors.white),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Container(
                                //                       width: size.width / 3,
                                //                       child: Padding(
                                //                         padding:
                                //                             EdgeInsets.symmetric(
                                //                                 horizontal: 10),
                                //                         child: ChoiceChip(
                                //                           label: Text("Incomplete"),
                                //                           selected: _orderController
                                //                                   .orderStatusValue
                                //                                   .value ==
                                //                               1,
                                //                           selectedColor:
                                //                               Colors.blue,
                                //                           onSelected:
                                //                               (bool selected) {
                                //                             _orderController
                                //                                 .orderStatusValue
                                //                                 .value = 1;

                                //                             print("Oder Statues Curent :" +
                                //                                 _orderController
                                //                                     .orderStatusValue
                                //                                     .value
                                //                                     .toString());
                                //                           },
                                //                           backgroundColor:
                                //                               Colors.grey,
                                //                           labelStyle: TextStyle(
                                //                               color: Colors.white),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Container(
                                //                       width: size.width / 3,
                                //                       child: Padding(
                                //                         padding: EdgeInsets.all(10),
                                //                         child: ChoiceChip(
                                //                           label: Text("Complete"),
                                //                           selected: _orderController
                                //                                   .orderStatusValue
                                //                                   .value ==
                                //                               2,
                                //                           selectedColor:
                                //                               Colors.blue,
                                //                           onSelected:
                                //                               (bool selected) {
                                //                             _orderController
                                //                                 .orderStatusValue
                                //                                 .value = 2;
                                //                           },
                                //                           backgroundColor:
                                //                               Colors.grey,
                                //                           labelStyle: TextStyle(
                                //                               color: Colors.white),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //     ),
                                //   ),
                                // ),
                                //items filter not working try to add method in init controller
                                Obx(() => _orderController.orderList != null
                                    ? Expanded(
                                        child: RefreshIndicator(
                                            onRefresh: () async {
                                              onRefresh();
                                            },
                                            child: Stack(
                                              children: [
                                                _orderController
                                                            .getFilterdOrderList(
                                                                _orderController
                                                                    .orderStatusValue
                                                                    .value)
                                                            .length !=
                                                        0
                                                    ? ListView.builder(
                                                        controller:
                                                            _orderController
                                                                .scrollController,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        // const BouncingScrollPhysics(
                                                        //     parent:
                                                        //         AlwaysScrollableScrollPhysics()),
                                                        itemCount: _orderController
                                                            .getFilterdOrderList(
                                                                _orderController
                                                                    .orderStatusValue
                                                                    .value)
                                                            .length,
                                                        itemBuilder: (context,
                                                            position) {
                                                          return ProductTile(
                                                            index: position,
                                                            order: _orderController
                                                                .getFilterdOrderList(
                                                                    _orderController
                                                                        .orderStatusValue
                                                                        .value)[position],
                                                          );
                                                        },
                                                      )
                                                    : Center(
                                                        child: Text(
                                                          "No order found",
                                                          style: TextStyle(
                                                              fontSize: 24),
                                                        ),
                                                      ),
                                                _orderController
                                                            .isFetching.value ==
                                                        true
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : SizedBox()
                                              ],
                                            )),
                                      )
                                    : CircularProgressIndicator()),
                              ],
                            ),
                    ),
            ),
          ),
          Positioned(
            left: size.width / 2.2,
            bottom: size.height / 80,
            child: Obx(
              () => _dashBoardController.userModel.value != null
                  ? _dashBoardController.userModel.value.data.role == "1" ||
                          _dashBoardController.userModel.value.data.role == "2"
                      ? FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                // duration: Duration(milliseconds: 500),
                                child: CreateOrderScreen(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: kPrimaryColorDark,
                          ),
                        )
                      : Container()
                  : Container(),
            ),
          )
        ],
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  onRefresh() => Future.delayed(Duration(seconds: 2), () {
        // _orderController.isScrolling.value = false;
        //  _orderController.totalPage.value = 0;
        _orderController.currentPage.value = 1;
        _orderController.getAllOrders(
            1, 10, _orderController.orderStatusValue.value);
      });
}

class DropDownItemChild extends StatelessWidget {
  final text;
  final Function ontap;
  const DropDownItemChild({Key key, this.text, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: InkWell(child: Text(text), onTap: ontap),
    );
  }
}
