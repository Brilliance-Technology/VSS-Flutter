import 'package:dio/dio.dart';
import 'package:inventory_management/app/constants/endpoints.dart';
import 'package:inventory_management/app/data/dio_client.dart';
import 'package:inventory_management/app/data/models/bar_graph_model.dart';
import 'package:inventory_management/app/data/models/pi_chart_model.dart';
import 'package:inventory_management/app/data/models/total_count.dart';

class DashBoardService {
  DioClient _dioClient = DioClient();
// peiChart/getstock?sales_id=60a5f4f1492add07db681d62&startDate=06/04/2021&endDate=22/04/2021
// 10:29
// url iski
  Future<PieChartModel> getPieChartDataBySalesId(
      {String salesID, String startDate, String endDate}) async {
    print("${Endpoints.baseUrl}${Endpoints.salesManagerPie}$salesID&");
    try {
      final response = await _dioClient.get(
        "${Endpoints.baseUrl}${Endpoints.pieChart}startDate=$startDate&endDate=$endDate",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Pie chart Data");
      print(response.data);
      return PieChartModel.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<BarGraphData> getAllBarGraphData(
      String startDate, String endDate) async {
    print(
        "${Endpoints.baseUrl}/graph/getadmin?startDate=$startDate&endDate=$endDate");
    try {
      final response = await _dioClient.get(
        "${Endpoints.baseUrl}/graph/getadmin?startDate=$startDate&endDate=$endDate",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Graph  Data");
      print(response.data);
      return BarGraphData.fromJson(response.data);
    } catch (e) {
      throw e;
    }
    
  }

  Future<BarGraphData> getBarGraphDataBySalesId(
      String startDate, String endDate, String salesId) async {
    print(
        "${Endpoints.baseUrl}/graph/getadmin?startDate=$startDate&endDate=$endDate&sales_id=$salesId");
    try {
      final response = await _dioClient.get(
        "${Endpoints.baseUrl}/graph/getadmin?startDate=$startDate&endDate=$endDate&sales_id=$salesId",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Graph  Data  By sales");
      print(response.data);
      return BarGraphData.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<TotalCounts> getTotalAllCountsById({
    String salesID,
  }) async {
    print("${Endpoints.baseUrl}${Endpoints.totalsCountBySales}$salesID&");
    try {
      final response = await _dioClient.get(
        "${Endpoints.baseUrl}${Endpoints.totalsCountBySales}$salesID",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Total Counts  Data");
      print(response.data);
      return TotalCounts.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<TotalCounts> getTotalAllCounts() async {
    print("${Endpoints.baseUrl}${Endpoints.totalsCount}&");
    try {
      final response = await _dioClient.get(
        "${Endpoints.baseUrl}${Endpoints.totalsCount}",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("Total Counts  Data");
      print(response.data);
      return TotalCounts.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
