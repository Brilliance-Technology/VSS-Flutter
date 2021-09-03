import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/controllers/conectivity_tester.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/controllers/orders_controller.dart';
import 'package:inventory_management/common/date_picker.dart';
import 'package:inventory_management/meta/screens/dashboard/dashboard_screen.dart';
import 'package:inventory_management/meta/screens/orders/orders_screen.dart';
import 'package:inventory_management/meta/screens/readymade/readymade_screen.dart';
import 'package:inventory_management/meta/screens/user_profile_screen/user_profile_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityTester connectivityTester = Get.put(ConnectivityTester());

  DashBoardController _dashBoardController = Get.put(DashBoardController());
  final OrderController _orderController = Get.put(OrderController());

  @override
  void initState() {
    _dashBoardController.loadSharedPrefs();
    // More handling code...

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorDark,
        body: Obx(
          () => _dashBoardController.isUserLoaded.value == true ?? false
              ? DefaultTabController(
                  initialIndex:
                      _dashBoardController.userModel.value.data.role == "3" ||
                              _dashBoardController.userModel.value.data.role ==
                                  "4"
                          ? 0
                          : 1,
                  length: _dashBoardController.userModel.value.data.role ==
                              "3" ||
                          _dashBoardController.userModel.value.data.role == "4"
                      ? 1
                      : 3,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, bool) => [
                      SliverAppBar(
                        actions: [
                          _dashBoardController.userModel.value.data.role ==
                                      "1" ||
                                  _dashBoardController
                                          .userModel.value.data.role ==
                                      "2"
                              ? _salesAndProductionOrdersFilter()
                              : _dashBoardController
                                          .userModel.value.data.role ==
                                      "3"
                                  ? _inchargeOrdersFilter()
                                  : _dispatchOrdersFilter(),

                          // Padding(
                          //   padding: EdgeInsets.only(right: 10),
                          //   child: GestureDetector(
                          //     onTap: () {},
                          //     child: Icon(
                          //       Icons.filter_alt,
                          //       size: 25,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // )
                        ],
                        title: Text(
                          "VSS",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        centerTitle: true,
                        elevation: 0,
                        collapsedHeight: size.height / 8,
                        flexibleSpace: Container(
                          color: kPrimaryColorDark,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height / 20,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 30),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          child: UserProfile(),
                                          type: PageTransitionType.leftToRight,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: size.height / 20,
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: tabBar()),
                              ),

                              // Container(
                              //   width: size.width,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       // Spacer(
                              //       //   flex: 3,
                              //       // ),
                              //       // Padding(
                              //       //     padding: EdgeInsets.symmetric(vertical: 5),
                              //       //     child: Image.asset(
                              //       //       "assets/images/text_logo2.png",
                              //       //       fit: BoxFit.contain,
                              //       //       width: MediaQuery.of(context).size.width *
                              //       //           0.15,
                              //       //       height:
                              //       //           MediaQuery.of(context).size.width *
                              //       //               0.15,
                              //       //     )),
                              //       // Spacer(
                              //       //   flex: 2,
                              //       // ),
                              //       // Padding(
                              //       //   padding: const EdgeInsets.only(
                              //       //     right: 10,
                              //       //   ),
                              //       //   child: GestureDetector(
                              //       //     onTap: () {
                              //       //       // loadSharedPrefs(context);
                              //       //       Navigator.push(
                              //       //         context,
                              //       //         PageTransition(
                              //       //           duration: Duration(milliseconds: 500),
                              //       //           child: UserProfile(),
                              //       //           type: PageTransitionType.leftToRight,
                              //       //         ),
                              //       //       );
                              //       //     },
                              //       //     child: CircleAvatar(
                              //       //         backgroundImage: AssetImage(
                              //       //             "assets/images/robert.jpeg")),
                              //       //   ),
                              //       // )
                              //     ],
                              //   ),
                              // ),

                              // SizedBox(
                              //   height: size.height / 11,
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                    body: Container(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        margin: EdgeInsets.only(top: size.height / 50),
                        child: Column(
                          children: [
                            Expanded(
                              child: Obx(
                                () => _dashBoardController
                                                .userModel.value.data.role ==
                                            "3" ||
                                        _dashBoardController
                                                .userModel.value.data.role ==
                                            "4"
                                    ? TabBarView(children: [OrdersScreen()])
                                    : TabBarView(children: [
                                        SingleChildScrollView(
                                            child: DashboardScreen()),
                                        OrdersScreen(),
                                        ReadymadeScreen(),
                                      ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  PopupMenuButton<int> _dispatchOrdersFilter() {
    final TextEditingController _dateFilter = TextEditingController(
        text: (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString());
    return PopupMenuButton(
        onSelected: (int value) {
          print("Pop up Menu Pressed ----------------");
          if (_orderController.orderList.toList().isNotEmpty) {
            if (value == 1) {
              _orderController.orderStatusValue.value = 4;
            } else if (value == 2) {
              _orderController.orderStatusValue.value = 2;
            } else if (value == 3) {
              _orderController.orderStatusValue.value = 3;
            }
          }
          if (value == 5) {
            print("Date Filter pressed");

            Get.dialog(Dialog(
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
                              "Order Filter",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
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
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: Get.size.width / 10),
                      child: Card(
                        elevation: 11,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: TextField(
                          controller: _dateFilter,
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            CustomDatePicker(false, isForFilter: true)
                                .selectDate(
                                    context: context,
                                    deliveryDate: DateTime.now(),
                                    dateController: _dateFilter);
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
                            labelText: "Filter Date",
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
                    Container(
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
                          OrderController _orderController =
                              Get.put(OrderController());
                          _orderController.getOrderByDate(_dateFilter.text);
                          Get.back();
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
                    )
                  ],
                ),
              ),
            ));
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        icon: Icon(
          Icons.filter_alt,
          size: 25,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("All"), Divider()],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Incomplete"), Divider()],
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Delivered"), Divider()],
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                  ],
                ),
                value: 5,
              ),
            ]);
  }

  PopupMenuButton<int> _inchargeOrdersFilter() {
    final TextEditingController _dateFilter = TextEditingController(
        text: (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString());
    return PopupMenuButton(
        onSelected: (int value) {
          print("Pop up Menu Pressed ----------------");
          if (_orderController.orderList.toList().isNotEmpty) {
            if (value == 1) {
              _orderController.orderStatusValue.value = 4;
            } else if (value == 2) {
              _orderController.orderStatusValue.value = 1;
            } else if (value == 3) {
              _orderController.orderStatusValue.value = 2;
            }
          }
          if (value == 5) {
            print("Date Filter pressed");

            Get.dialog(Dialog(
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
                              "Order Filter",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
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
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: Get.size.width / 10),
                      child: Card(
                        elevation: 11,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: TextField(
                          controller: _dateFilter,
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            CustomDatePicker(false, isForFilter: true)
                                .selectDate(
                                    context: context,
                                    deliveryDate: DateTime.now(),
                                    dateController: _dateFilter);
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
                            labelText: "Filter Date",
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
                    Container(
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
                          OrderController _orderController =
                              Get.put(OrderController());
                          _orderController.getOrderByDate(_dateFilter.text);
                          Get.back();
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
                    )
                  ],
                ),
              ),
            ));
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        icon: Icon(
          Icons.filter_alt,
          size: 25,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("All"), Divider()],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Incomplete"), Divider()],
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Complete"), Divider()],
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                  ],
                ),
                value: 5,
              ),
            ]);
  }

  PopupMenuButton<int> _salesAndProductionOrdersFilter() {
    final TextEditingController _dateFilter = TextEditingController(
        text: (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString());
    return PopupMenuButton(
        onSelected: (int value) {
          print("Pop up Menu Pressed ----------------");
          if (_orderController.orderList.toList().isNotEmpty) {
            if (value == 1) {
              _orderController.orderStatusValue.value = 4;
            } else if (value == 2) {
              _orderController.orderStatusValue.value = 1;
            } else if (value == 3) {
              _orderController.orderStatusValue.value = 0;
            } else if (value == 4) {
              _orderController.orderStatusValue.value = 3;
              print(_orderController.orderStatusValue.value);
            }
          }
          if (value == 5) {
            print("Date Filter pressed");

            Get.dialog(Dialog(
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
                              "Order Filter",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
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
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: Get.size.width / 10),
                      child: Card(
                        elevation: 11,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: TextField(
                          controller: _dateFilter,
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            CustomDatePicker(false, isForFilter: true)
                                .selectDate(
                                    context: context,
                                    deliveryDate: DateTime.now(),
                                    dateController: _dateFilter);
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
                            labelText: "Filter Date",
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
                    Container(
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
                          OrderController _orderController =
                              Get.put(OrderController());
                          _orderController.getOrderByDate(_dateFilter.text);
                          Get.back();
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
                    )
                  ],
                ),
              ),
            ));
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        icon: Icon(
          Icons.filter_alt,
          size: 25,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("All"), Divider()],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Accepted"), Divider()],
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Pending"), Divider()],
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Delivered"), Divider()],
                ),
                value: 4,
              ),
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                  ],
                ),
                value: 5,
              ),
            ]);
  }

  Widget tabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => TabBar(
            labelColor: kPrimaryColorDark,
            unselectedLabelColor: darkColor.withOpacity(0.3),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            tabs: _dashBoardController.userModel.value.data.role == "3" ||
                    _dashBoardController.userModel.value.data.role == "4"
                ? [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                : [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Ready",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
      ),
    );
  }
}
