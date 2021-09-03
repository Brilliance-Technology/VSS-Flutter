import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/endpoints.dart';
import 'package:inventory_management/app/data/dio_client.dart';
import 'package:inventory_management/app/data/models/production_incharge_assign_model.dart';
import 'package:inventory_management/app/data/models/users_list_model.dart';

class ProductionHeadController extends GetxController {
  List<Re> inchargeList = List.empty(growable: true);
  assignOrderByPH(String orderId, String pid,
      ProductionInchargeAssignModel productAssign) async {
    DioClient _dioClient = DioClient();
    try {
      dynamic data = {
        "orderId": orderId,
        "pid": pid,
        "updateType": "productionInUpdate",
        "products": productAssign.toJson()
      };
      print(data);
      final response = await _dioClient.put(
        "${Endpoints.baseUrl + "${Endpoints.editSales}/$orderId"}",
        data: data,
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );

      print("response");
      print(response);
    } catch (e) {
      throw e;
    }
  }
}
