import 'dart:convert';

class AuthenticationResponse {
  final String? message;
  final UserData? data;
  final bool? status;
  final int? code;

  AuthenticationResponse({this.message, this.data, this.status, this.code});

  factory AuthenticationResponse.fromJson(String str) =>
      AuthenticationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthenticationResponse.fromMap(Map<String, dynamic> json) =>
      AuthenticationResponse(
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromMap(json["data"]),
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": data?.toMap(),
    "status": status,
    "code": code,
  };
}

class UserData {
  final String? token;
  final String? username;

  UserData({this.token, this.username});

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) =>
      UserData(token: json["token"], username: json["username"]);

  Map<String, dynamic> toMap() => {"token": token, "username": username};
}
