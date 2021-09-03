import 'dart:convert';

CreateOrderResponse createOrderResponseFromJson(String str) =>
    CreateOrderResponse.fromJson(json.decode(str));

String createOrderResponseToJson(CreateOrderResponse data) =>
    json.encode(data.toJson());

class CreateOrderResponse {
  CreateOrderResponse({
    this.status,
    this.msg,
  });

  int status;
  String msg;

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponse(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
