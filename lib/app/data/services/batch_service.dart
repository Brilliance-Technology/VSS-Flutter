import 'package:dio/dio.dart';
import 'package:inventory_management/app/constants/endpoints.dart';
import 'package:inventory_management/app/data/dio_client.dart';
import 'package:inventory_management/app/data/models/batch_filter_model.dart';

class BatchService {
  // thickness_selected
  // width_selected
  // color_selected
  DioClient _dioClient = DioClient();

  Future<BatchFilterModel> getFilterBatches(
      double thickness, double width, String color) async {
    try {
      Map<String, dynamic> map = {
        "thickness_selected": thickness,
        "width_selected": width,
        "color_selected": color,
      };
      final response = await _dioClient.post(
        "${Endpoints.baseUrl}/log/B/FilterStock", //Endpoints.filterBatch}",
        data: map,
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      return BatchFilterModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<Null> submitBatch(BatchUpdateModel model) async {
    try {
      final response = await _dioClient.post(
        "${Endpoints.baseUrl}/log2/update/${model.batchId}",
        data: model.toJson(),
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      print("response of batch update");
      print(response);
    } catch (e) {
      throw e;
    }
  }

  Future<BatchFilterModel> addBatchListToProduct(String orderId, String pid,
      List<Map<String, dynamic>> batchMapList) async {
    try {
      dynamic data = {
        "orderId": orderId,
        "pid": pid,
        "updateType": "batchUpdate",
        "products": {"batch_list": batchMapList}
      };

      if (data != null) {
        final response = await _dioClient.put(
          "${Endpoints.baseUrl + "${Endpoints.editSales}/$orderId"}",
          data: data,
          options:
              Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
        );
        print("response");
        print(response);
      }
      return BatchFilterModel();
    } catch (e) {
      throw e;
    }
  }
}
