// To parse this JSON data, do
//
//     final signInModel = signInModelFromMap(jsonString);

import 'dart:convert';

SignInModel signInModelFromMap(String str) =>
    SignInModel.fromMap(json.decode(str));

String signInModelToMap(SignInModel data) => json.encode(data.toMap());

class SignInModel {
  SignInModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data? data;

  factory SignInModel.fromMap(Map<String, dynamic> json) => SignInModel(
        code: json["code"] == null ? 0 : json["code"],
        message: json["message"] == '' ? null : json["message"],
        data: json["data"] == null
            ? Data(
                id: 0,
                userType: '',
                surname: '',
                firstName: '',
                lastName: '',
                username: '',
                email: '',
                businessId: 0,
                status: '',
                roleId: '',
                voide: '',
                voidLimit: '',
                passwordString: '',
                location: [],
                bearer: '',
                media: '')
            : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.userType,
    required this.surname,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.businessId,
    required this.status,
    required this.roleId,
    required this.voide,
    required this.voidLimit,
    required this.passwordString,
    required this.location,
    required this.bearer,
    required this.media,
  });

  int id;
  String userType;
  String surname;
  String firstName;
  String lastName;
  String username;
  String email;
  int businessId;
  String status;
  dynamic roleId;
  dynamic voide;
  dynamic voidLimit;
  dynamic passwordString;
  List<LocationFromApi>? location;
  String bearer;
  dynamic media;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        userType: json["user_type"] == null ? null : json["user_type"],
        surname: json["surname"] == null ? null : json["surname"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        businessId: json["business_id"] == null ? null : json["business_id"],
        status: json["status"] == null ? null : json["status"],
        roleId: json["role_id"],
        voide: json["voide"],
        voidLimit: json["void_limit"],
        passwordString: json["password_string"],
        location: json["location"] == null
            ? null
            : List<LocationFromApi>.from(
                json["location"].map((x) => LocationFromApi.fromMap(x))),
        bearer: json["Bearer"] == null ? null : json["Bearer"],
        media: json["media"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_type": userType == null ? null : userType,
        "surname": surname == null ? null : surname,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "business_id": businessId == null ? null : businessId,
        "status": status == null ? null : status,
        "role_id": roleId,
        "voide": voide,
        "void_limit": voidLimit,
        "password_string": passwordString,
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x.toMap())),
        "Bearer": bearer == null ? null : bearer,
        "media": media,
      };
}

class LocationFromApi {
  LocationFromApi({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory LocationFromApi.fromMap(Map<String, dynamic> json) => LocationFromApi(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
      };
}
