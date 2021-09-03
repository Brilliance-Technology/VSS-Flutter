import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';

class PieChartComponent extends StatefulWidget {
  @override
  _PieChartComponentState createState() => _PieChartComponentState();
}

// List<Stock> stock = [
//   Stock(id: Id(product: "GPC"), count: 9),
//   Stock(id: Id(product: "dw"), count: 8),
//   Stock(id: Id(product: "a"), count: 7),
//   Stock(id: Id(product: "abc"), count: 6),
//   Stock(id: Id(product: "efd"), count: 5),
//   Stock(id: Id(product: "xyz"), count: 4),
//   Stock(id: Id(product: "123"), count: 3),
//   Stock(id: Id(product: "lkg"), count: 2),
//   Stock(id: Id(product: "qwz"), count: 9),
// ];
// List<SoldProduct> soldProduct = [
//   SoldProduct(id: "GPC", count: 4),
//   SoldProduct(id: "abc", count: 8),
//   SoldProduct(id: "lkg", count: 7),
//   SoldProduct(id: "qwz", count: 6),
//   SoldProduct(id: "efd", count: 2),
//   SoldProduct(id: "a", count: 1),
//   SoldProduct(id: "123", count: 1)
// ];

class _PieChartComponentState extends State<PieChartComponent> {
  final _dashBoardController = Get.put(DashBoardController());
  List<Widget> _list = List.empty(growable: true);
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();

    setState(() {
      _list = getProduct().toList();
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: isLoaded == true
            ? Container(
                child: GridView.builder(
                    itemCount: _list.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return _list[index];
                    }),
              )
            : CircularProgressIndicator());
  }

  List<Widget> getProduct() {
    List<Widget> _sectionData = List.empty(growable: true);
    _dashBoardController.availableProductPieList.forEach((stockElement) {
      _dashBoardController.soldProductPieList.forEach((element) {
        if (stockElement.id == element.id) {
          _sectionData.add(
            PieChartWidget(
              productName: stockElement.id,
              stockCount: stockElement.count.toDouble(),
              soldCount: element.count.toDouble(),
            ),
          );
        } else {
          // _sectionData.add(
          //   PieChartWidget(
          //       productName: stockElement.id,
          //       stockCount: stockElement.count.toDouble(),
          //       soldCount: 1.0 //element.count.toDouble(),
          //       ),
          // );
        }
      });
    });

    return _sectionData;
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget(
      {Key key, this.productName, this.stockCount, this.soldCount})
      : super(key: key);
  final double stockCount;
  final double soldCount;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: Get.width,
      child: Column(children: [
        Expanded(
          child: Container(
            child: Row(
              children: [
                Spacer(),
                Text(productName.toString().toUpperCase()),
                Spacer(),
                Expanded(
                  child: Container(
                    child: PieChart(
                      PieChartData(sections: [
                        PieChartSectionData(
                          showTitle: true,
                          color: kPrimaryColorDark, //
                          //   color: Color(0xff1b263b),
                          value: stockCount,
                          title: stockCount.toString(),
                          radius: Get.width / 7,
                          titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffffffff)),
                        ),
                        PieChartSectionData(
                          color: kPrimaryColorLight,
                          // color:  Color(0xff415a77),
                          value: soldCount,
                          title: soldCount.toString(),
                          // title: ((soldCount / stockCount) * 100)
                          //         .toStringAsFixed(0) +
                          //     "%",
                          radius: Get.width / 7,
                          titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffffffff)),
                        ),
                      ], sectionsSpace: 0, centerSpaceRadius: 0),
                      swapAnimationDuration: Duration(seconds: 150),
                      swapAnimationCurve: Curves.linear,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width / 3,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width / 50,
                        ),
                        Expanded(child: Text("Sold ")),
                        Container(
                          width: Get.width / 30,
                          height: Get.height / 30,
                          child: CircleAvatar(
                              backgroundColor:
                                  kPrimaryColorLight //Color(0xfff8b250),
                              // child: Container(
                              //   width: 2,
                              //   height: 2,
                              // ),
                              ),
                        ),
                        SizedBox(
                          width: Get.width / 20,
                        ),
                        Expanded(child: Text(soldCount.toString())),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width / 3,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width / 50,
                        ),
                        Expanded(
                            child: Container(
                                width: Get.width / 3, child: Text("Stock"))),
                        Container(
                          width: Get.width / 30,
                          height: Get.height / 30,
                          child: CircleAvatar(
                            backgroundColor: kPrimaryColorDark,
                            // Color(0xff0293ee),
                            child: Container(
                              width: 2,
                              height: 2,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 20,
                        ),
                        Expanded(
                            child: Container(
                                width: Get.width / 3,
                                child: Text(stockCount.toString()))),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
