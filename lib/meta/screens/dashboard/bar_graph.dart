import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/controllers/bar_graph_controller.dart';
import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/data/models/bar_graph_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarGraphWidget extends StatelessWidget {
//   // final List<Color> availableColors = [
//   //   Colors.purpleAccent,
//   //   Colors.yellow,
//   //   Colors.lightBlue,
//   //   Colors.orange,
//   //   Colors.pink,
//   //   Colors.redAccent,
//   // ];

//   @override
//   _BarGraphWidgetState createState() => _BarGraphWidgetState();
// }

// class _BarGraphWidgetState extends State<BarGraphWidget> {
  final BarGraphController _barGraph = Get.find();
  final Color barBackgroundColor = const Color(0xff415a77);
  final DashBoardController _dashBoardController = Get.find();
  final formater = DateFormat('dd/MM/yyyy');
  // int touchedIndex;
  // int _value = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() => _barGraph.graphData.isEmpty
        ? SizedBox(
            child: Center(
              child: Text("No Sales Found "),
            ),
          )
        : Container(
            child: BarGraphSingleBar(),
          ));
  }
}

class BarGraphSingleBar extends StatelessWidget {
  final BarGraphController _barGraph = Get.find();
  final blue = charts.MaterialPalette.indigo.makeShades(2);
  // final red = charts.MaterialPalette.red.makeShades(2);
  // final green = charts.MaterialPalette.green.makeShades(2);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarGraph, String>> series = [
      charts.Series(
          id: "graph",
          data: _barGraph.graphData,
          domainFn: (BarGraph graph, _) => _barGraph.graphRange.value == "DAY"
              ? graph.xAxisLabel.split(" ").first +
                  " " +
                  graph.xAxisLabel.split(" ")[1]
              : graph.xAxisLabel,
          colorFn: (_, index) => index % 2 == 0
              ? charts.ColorUtil.fromDartColor(kPrimaryColorDark)
              : charts.ColorUtil.fromDartColor(Color(0xff5687AA)),
          // _barGraph.graphRange.value == "YEAR"
          //     ? graph.id.month.toString() + "/" + graph.id.year.toString()
          //     : graph.id.day.toString() + "/" + graph.id.month.toString(),
          measureFn: (BarGraph graph, _) => graph.weight.round(),
          overlaySeries: false),
    ];
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(left: Get.size.width / 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kComponnetBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: Get.size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Bar Graph")),
            Container(
              // margin: EdgeInsets.only(left: Get.size.width / 20),

              padding: EdgeInsets.symmetric(horizontal: 10),
              height: Get.size.height / 2.4,
              width: _barGraph.graphRange.value == "YEAR"
                  ? Get.size.width * 2
                  : _barGraph.graphRange.value == "DAY"
                      ? Get.size.width
                      : Get.size.width * 3.2,
              child: charts.BarChart(
                series,
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//            SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Container(
//                 width: _barGraph.graphData.length > 12
//                     ? size.width * 1.5
//                     : size.width,
//                 height: size.height / 2.5,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18)),
//                   color: Color(0xff1b263b),
//                   child: Stack(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: <Widget>[
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Sales Graph',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(
//                                         height: 4,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width / 20,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 38,
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: BarChart(
//                                   mainBarData(),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     bool isTouched = false,
//     Color barColor = Colors.white,
//     double width = 4,
//     List<int> showTooltips = const [],
//   }) {
//     // List<BarGraph> temp = _barGraph.graphData;
//     // temp.sort(((a, b) => a.weight.compareTo(b.weight)));
//     List<BarGraph> sortedData = _barGraph.graphData;
//     sortedData.sort(((a, b) => a.weight.compareTo(b.weight)));
//     return BarChartGroupData(
//       barsSpace: _barGraph.graphData.length > 7 ? 4 : 10,
//       x: x,
//       barRods: [
//         BarChartRodData(
//           y: isTouched ? y + 1 : y,
//           colors: isTouched ? [Colors.yellow] : [barColor],
//           width: width,
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             y: sortedData.last.weight * 1.5,
//             colors: [barBackgroundColor],
//           ),
//         ),
//       ],
//       showingTooltipIndicators: showTooltips,
//     );
//   }

//   // List<BarChartGroupData> showingGroupsWeekly() => List.generate(7, (i) {
//   //       switch (i) {
//   //         case 0:
//   //           return makeGroupData(0, 5, isTouched: i == touchedIndex);
//   //         case 1:
//   //           return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
//   //         case 2:
//   //           return makeGroupData(2, 5, isTouched: i == touchedIndex);
//   //         case 3:
//   //           return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
//   //         case 4:
//   //           return makeGroupData(4, 9, isTouched: i == touchedIndex);
//   //         case 5:
//   //           return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
//   //         case 6:
//   //           return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
//   //         default:
//   //           return null;
//   //       }
//   //     });
//   //check
//   List<BarChartGroupData> showingGroupsMonthly() {
//     List<BarChartGroupData> _data = List.empty(growable: true);
//     int count = 0;
//     _barGraph.graphData.toList().forEach((element) {
//       print(element.id);
//       _data.add(makeGroupData(element.id.day, element.weight,
//           width: _barGraph.graphData.length > 7 ? 4 : 12,
//           isTouched: count == touchedIndex));

//       count++;
//     });
//     return _data;
//   }

// //check
//   BarChartData mainBarData() {
//     return BarChartData(
//       alignment: BarChartAlignment.center,
//       groupsSpace: 10,
//       //   barTouchData: BarTouchData(enabled: false),
//       barTouchData: BarTouchData(
//         allowTouchBarBackDraw: false,
//         touchTooltipData: BarTouchTooltipData(
//             tooltipBgColor: Colors.blueGrey,
//             getTooltipItem: (group, groupIndex, rod, rodIndex) {
//               String xData;

//               xData = // formater
//                   // .format(_barGraph.graphData[group.x.toInt()].id)
//                   // .toString();
//                   _barGraph.graphData[rodIndex].id.day.toString();
//               return BarTooltipItem(
//                 xData + '\n',
//                 TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: (_barGraph.graphData[rodIndex].weight / 1000)
//                             .toString() +
//                         " T",
//                     style: TextStyle(
//                       color: Colors.yellow,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//         touchCallback: (barTouchResponse) {
//           setState(() {
//             if (barTouchResponse.spot != null &&
//                 barTouchResponse.touchInput is! PointerUpEvent &&
//                 barTouchResponse.touchInput is! PointerExitEvent) {
//               touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
//             } else {
//               touchedIndex = -1;
//             }
//           });
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: SideTitles(
//           rotateAngle: -45,
//           showTitles: true,
//           getTextStyles: (value) => const TextStyle(
//               color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
//           margin: 16,
//           getTitles: (double value) {
//             return value.toString();
//             // _barGraph.graphData
//             //     .toList()
//             //     .firstWhere((element) => element.weight / 1000 == value)
//             //     .id
//             //     .day
//             //     .toString();
//             // return _barGraph.graphData.toList()[value.toInt()].id.day.toString() +
//             //     "/" +
//             //     _barGraph.graphData.toList()[value.toInt()].id.month.toString();
//           },
//         ),
//         leftTitles: SideTitles(
//           showTitles: false,
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),

//       barGroups: showingGroupsMonthly(),
//     );
//   }
//}
