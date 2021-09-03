import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String getRole(String role) {
    if (role == "1")
      return "Sale's Manager";
    else if (role == "2")
      return "Production Head";
    else if (role == "3")
      return "Production Incharge";
    else if (role == "4") return "Dispatch Manager";
  }

  UserModel({this.status, this.data, this.msg});

  String status;
  Data data;
  String msg;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      status: json["status"],
      data: Data.fromJson(json["data"]),
      msg: json["msg"] ?? "");

  Map<String, dynamic> toJson() =>
      {"status": status, "data": data.toJson(), "msg": msg};
}

class Data {
  Data(
      {this.id,
      this.userId,
      this.role,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.email,
      this.address,
      this.city,
      this.pincode,
      this.joinedDate,
      this.shiftTime,
      this.tenure,
      this.token,
      this.userImage});

  String id;
  String userId;
  String role;
  String firstName;
  String lastName;
  int phoneNo;
  String email;
  String address;
  String city;
  int pincode;
  String joinedDate;
  String shiftTime;
  String tenure;
  String token;
  String userImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["_id"],
      userId: json["user_id"],
      role: json["role"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phoneNo: json["phone_no"],
      email: json["email"],
      address: json["address"],
      city: json["city"],
      pincode: json["pincode"],
      joinedDate: json["joined_date"],
      shiftTime: json["shift_time"],
      tenure: json["tenure"],
      token: json["token"],
      userImage: json["user_image"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "role": role,
        "firstName": firstName,
        "lastName": lastName,
        "phone_no": phoneNo,
        "email": email,
        "address": address,
        "city": city,
        "pincode": pincode,
        "joined_date": joinedDate,
        "shift_time": shiftTime,
        "tenure": tenure,
        "token": token,
        "user_image": userImage
      };
}
