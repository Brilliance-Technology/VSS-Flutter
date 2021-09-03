import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/bar_graph_controller.dart';
import 'package:inventory_management/app/controllers/conectivity_tester.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/meta/screens/dashboard/bar_graph.dart';
import 'package:inventory_management/meta/screens/dashboard/components/custom_drop_down_child.dart';
import 'package:inventory_management/meta/screens/dashboard/pie_chart.dart';
import 'package:inventory_management/meta/screens/orders/orders_screen.dart';
import 'package:jiffy/jiffy.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final formater = DateFormat('yyyy/MM/dd');
  @override
  void initState() {
    _dashBoardController.getSalesManagerDashboardData(
        formater.format(DateTime.now().subtract(Duration(days: 7))).toString());
    _dashBoardController.loadSharedPrefs();
    _graphController
        .getgraphList((Jiffy(DateTime.now()).subtract(days: 7).dateTime));

    super.initState();
  }

  final _dashBoardController = Get.put(DashBoardController());
  final _graphController = Get.put(BarGraphController());

  final ConnectivityTester connectivityTester = Get.put(ConnectivityTester());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Obx(
        () => _dashBoardController.isSalesDataLoaded.value == true &&
                _graphController.isGraphDataLoaded.value == true
            ? Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () =>
                              _dashBoardController.totalCountsAll.value == null
                                  ? SizedBox()
                                  : firstStat(
                                      totalClients: _dashBoardController
                                                      .totalCountsAll
                                                      .value
                                                      .totalclients ==
                                                  null ||
                                              _dashBoardController
                                                      .totalCountsAll
                                                      .value
                                                      .totalclients ==
                                                  0
                                          ? "0"
                                          : _dashBoardController
                                              .totalCountsAll.value.totalclients
                                              .toString(),
                                      totalSalesCount: _dashBoardController
                                                      .totalCountsAll
                                                      .value
                                                      .totalsales ==
                                                  null ||
                                              _dashBoardController
                                                  .totalCountsAll
                                                  .value
                                                  .totalsales
                                                  .isEmpty
                                          ? "0"
                                          : _dashBoardController.totalCountsAll
                                              .value.totalsales.first.count
                                              .toString(),
                                      pendingOrders: _dashBoardController
                                                      .totalCountsAll
                                                      .value
                                                      .pendingOrder ==
                                                  null ||
                                              _dashBoardController
                                                  .totalCountsAll
                                                  .value
                                                  .pendingOrder
                                                  .isEmpty
                                          ? "0"
                                          : _dashBoardController
                                                  .totalCountsAll
                                                  .value
                                                  .pendingOrder
                                                  .first
                                                  .count
                                                  .toString() ??
                                              "0",
                                    ),
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 10,
                    //   ),
                    //   child: secondStat(totalOrder: "0", pending: "0"),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 20),
                      child: Card(
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // border: Border.all(color: Colors.black26)),
                          //width: size.width / 2.5,
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width / 50),
                          child: Obx(
                            () => DropdownButton(
                              isExpanded: true,
                              onChanged: (value) {
                                _dashBoardController.touchedIndex.value = value;
                              },
                              //dropdownColor: kPrimaryColor,
                              //style: TextStyle(color: Colors.white),
                              value: _dashBoardController.touchedIndex.value,

                              items: [
                                DropdownMenuItem(
                                  onTap: () {
                                    print(formater.format(DateTime.now()
                                        .subtract(Duration(days: 7))));
                                    _dashBoardController
                                        .getSalesManagerDashboardData(formater
                                            .format(DateTime.now()
                                                .subtract(Duration(days: 7)))
                                            .toString());
                                    _graphController.getgraphList(DateTime.now()
                                        .subtract(Duration(days: 7)));
                                    _graphController.graphRange.value = "DAY";
                                  },
                                  child: CustomDropDownChild(
                                    content: "Last 7 Days",
                                    endDate:
                                        "${formater.format(DateTime.now())}",
                                    startDate:
                                        "${formater.format(DateTime.now().subtract(Duration(days: 7))).toString()}",
                                  ),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    print(formater.format(Jiffy(DateTime.now())
                                        .subtract(months: 1)
                                        .dateTime));
                                    _dashBoardController
                                        .getSalesManagerDashboardData(formater
                                            .format(Jiffy(DateTime.now())
                                                .subtract(months: 1)
                                                .dateTime)
                                            .toString());
                                    _graphController.getgraphList(
                                        Jiffy(DateTime.now())
                                            .subtract(months: 1)
                                            .dateTime);
                                    _graphController.graphRange.value = "WEEK";
                                  },
                                  value: 1,
                                  child: CustomDropDownChild(
                                    content: "Last 1 Month",
                                    endDate:
                                        "${formater.format(DateTime.now())}",
                                    startDate:
                                        "${formater.format((Jiffy(DateTime.now()).subtract(months: 1).dateTime))}",
                                  ),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    print(formater.format(Jiffy(DateTime.now())
                                        .subtract(years: 1)
                                        .dateTime));
                                    _dashBoardController
                                        .getSalesManagerDashboardData(formater
                                            .format(Jiffy(DateTime.now())
                                                .subtract(years: 1)
                                                .dateTime)
                                            .toString());
                                    _graphController.getgraphList(
                                        Jiffy(DateTime.now())
                                            .subtract(years: 1)
                                            .dateTime);
                                    _graphController.graphRange.value = "YEAR";
                                  },
                                  value: 2,
                                  child: CustomDropDownChild(
                                    content: "Last 1 Year",
                                    endDate:
                                        "${formater.format(DateTime.now())}",
                                    startDate:
                                        "${formater.format((Jiffy(DateTime.now()).subtract(years: 1).dateTime))}",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: size.height / 20),
                    //   child: Container(
                    //     padding: const EdgeInsets.only(
                    //       left: 20,
                    //     ),
                    //     alignment: Alignment.topLeft,
                    //     child: Text(
                    //       "Bar Graph",
                    //       style: TextStyle(
                    //         fontSize: size.width * 0.04,
                    //         color: Colors.black87,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    BarGraphWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.height / 20),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sold Product ",
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      width: Get.width,
                      height: size.height,

                      child: PieChartComponent(),
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage("assets/images/bar_chart.png"),
                      //   ),
                    ),
                  ],
                ),
              )
            : Container(
                width: size.width,
                height: size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Row secondStat({String totalOrder, String pending}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.all(5),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    totalOrder,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: pending.length > 5 ? 16 : 20),
                  ),
                ),
                Text(
                  'Total Order',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer()
              ],
            )),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff415a77),
            ),
          ),
        ),
        // SizedBox(
        //   width: 6,
        // ),
        Flexible(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    pending,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: pending.length > 5 ? 16 : 20),
                  ),
                ),
                Text(
                  'Pending',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer()
              ],
            )),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff1b263b),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Row firstStat(
      {String totalSalesCount, String totalClients, String pendingOrders}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TotalsContainerWidget(
          label: 'Total Sales',
          value: totalSalesCount ?? "0",
        ),
        TotalsContainerWidget(
          label: 'Total Client',
          value: totalClients ?? "0",
        ),
        TotalsContainerWidget(
          label: 'Pending ',
          value: pendingOrders ?? "0",
        ),
      ],
    );
  }
}

class TotalsContainerWidget extends StatelessWidget {
  TotalsContainerWidget({this.label, this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 11,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                value,
                style: TextStyle(
                    color: kPrimaryColorDark,
                    fontSize: value.length > 5 ? 12 : 20),
              ),
            ),
            Text(
              label,
              style: TextStyle(color: kPrimaryColorDark, fontSize: 12),
            ),
            Spacer()
          ],
        )),
        width: Get.size.width / 5,
        height: Get.size.width / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kPrimaryColorLight,
        ),
      ),
    );
  }
}
