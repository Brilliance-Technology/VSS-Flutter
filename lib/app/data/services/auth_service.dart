import 'package:dio/dio.dart';
import 'package:inventory_management/app/constants/endpoints.dart';
import 'package:inventory_management/app/data/dio_client.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/models/users_list_model.dart';

class AuthService {
  DioClient _dioClient = DioClient();

  Future<UserModel> loginUser({int phoneNumber, String password}) async {
    try {
      dynamic data = {
        "phone_no": phoneNumber,
        "password": password,
      };

      final response =
          await _dioClient.post("${Endpoints.loginUser}", data: data);

      return UserModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<UsersListResponse> getAllPI() async {
    try {
      Response response = await _dioClient.get(
        "${Endpoints.productInchargeList}",
        options:
            Options(headers: {"Authorization": "${Endpoints.accessToken}"}),
      );
      return UsersListResponse.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
