import 'dart:convert';

UsersListResponse usersListResponseFromJson(String str) =>
    UsersListResponse.fromJson(json.decode(str));

String usersListResponseToJson(UsersListResponse data) =>
    json.encode(data.toJson());

class UsersListResponse {
  UsersListResponse({
    this.status,
    this.msg,
    this.res,
  });

  int status;
  String msg;
  List<Re> res;

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      UsersListResponse(
        status: json["status"],
        msg: json["msg"],
        res: json["res"] == null
            ? null
            : List<Re>.from(json["res"].map((x) => Re.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "res": List<dynamic>.from(res.map((x) => x.toJson())),
      };
}

class Re {
  Re({
    this.id,
    this.userImage,
    this.firstName,
    this.lastName,
    this.phoneNo,
    this.role,
    this.email,
    this.address,
    this.city,
    this.pincode,
    this.joinedDate,
    this.shiftTime,
    this.tenure,
    this.userId,
    this.password,
    this.v,
  });

  String id;
  String userImage;
  String firstName;
  String lastName;
  int phoneNo;
  String role;
  String email;
  String address;
  String city;
  int pincode;
  String joinedDate;
  String shiftTime;
  String tenure;
  String userId;
  String password;
  int v;

  factory Re.fromJson(Map<String, dynamic> json) => Re(
        id: json["_id"],
        userImage: json["user_image"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNo: json["phone_no"],
        role: json["role"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        pincode: json["pincode"],
        joinedDate: json["joined_date"],
        shiftTime: json["shift_time"],
        tenure: json["tenure"],
        userId: json["user_id"],
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_image": userImage,
        "firstName": firstName,
        "lastName": lastName,
        "phone_no": phoneNo,
        "role": role,
        "email": email,
        "address": address,
        "city": city,
        "pincode": pincode,
        "joined_date": joinedDate,
        "shift_time": shiftTime,
        "tenure": tenure,
        "user_id": userId,
        "password": password,
        "__v": v,
      };
}
