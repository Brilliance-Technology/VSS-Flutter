import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/data/exceptions.dart';
import 'package:inventory_management/app/data/models/bar_graph_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/app/data/services/dash_board_service.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';

class BarGraphController extends GetxController {
  var isGraphDataLoaded = false.obs;
  final formater = DateFormat('yyyy/MM/dd');
  DashBoardService _dashBoardService = DashBoardService();
  var graphData = List<BarGraph>.empty(growable: true).obs;
  var graphRange = "DAY".obs;

  getgraphList(DateTime startDate) async {
    isGraphDataLoaded.value = false;
    AppPrefs appPrefs = AppPrefs();
    String endDate = formater.format(DateTime.now()).toString();
    List<BarGraph> dateList = calculateDateInterval(startDate, DateTime.now());
    var user = await appPrefs.readUser(Constants.user_key);
    try {
      graphData.clear();
      print(
          "Start Date and End Date ${formater.format(startDate).toString()} $endDate");
      BarGraphData response = user.data.role == "1"
          ? await _dashBoardService.getBarGraphDataBySalesId(
              formater.format(startDate).toString(), endDate, user.data.id)
          : await _dashBoardService.getAllBarGraphData(
              formater.format(startDate).toString(), endDate);
      if (response.status == 200) {
        print("Length of Graph Data ${response.barGraphList.length}");
        print("Length of Date List ${dateList.length}");
        graphData.value = response.barGraphList.toSet().toList();

        // List<BarGraph> tempList = List<BarGraph>.empty(growable: true);
        // // List newList = [2, 4, 3];
        // print(
        //     "Len of graph data before operation-------------------${graphData.length}");
        // for (var item in graphData) {
        //   if (!tempList.contains(item)) {
        //     tempList.addAll(graphData
        //         .where((e) => e.xAxisLabel == item.xAxisLabel)
        //         .toList());
        //     //  tempList.add(item);
        //   }
        // }
        // graphData.value = tempList;
        print(
            "Len of graph data before operation-------------------${graphData.length}");
        //getUpdateGraphList(response.barGraphList, dateList);
        print("Length of Graph Data ${graphData.length}");
        // print("Graph Data for VSS--------------------------------------");
        // graphData.forEach((element) {
        //   print(element.id.toString() + " ," + element.weight.toString());
        // });
      }
    } catch (e) {
      print(e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showCustomDialog(Get.context, 'Error', errorMessage, () {
        Navigator.of(Get.context).pop();
      });
    } finally {
      print("is Sales Data Loaded :${isGraphDataLoaded.value}");
      isGraphDataLoaded.value = true;
      print("is Sales Data Loaded :${isGraphDataLoaded.value}");
    }
  }

  List<BarGraph> getUpdateGraphList(
      List<BarGraph> apiGraphList, List<BarGraph> dateIntervalList) {
    apiGraphList.forEach((e) {
      dateIntervalList.forEach((element) {
        if (e.id.day == element.id.day) {
          element.weight = e.weight;
          element.xAxisLabel = e.xAxisLabel;
        }
      });
    });
    return dateIntervalList;
  }

  List<BarGraph> calculateDateInterval(DateTime startDate, DateTime endDate) {
    List<BarGraph> days = List<BarGraph>.empty(growable: true);
    for (int i = 0; i < endDate.difference(startDate).inDays; i++) {
      days.add(BarGraph(
          id: startDate.add(Duration(days: i)), weight: 0.0, xAxisLabel: ""));
    }
    return days;
  }
}
