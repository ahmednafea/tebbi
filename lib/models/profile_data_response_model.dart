import 'dart:convert';

class ProfileDataResponse {
  final String? message;
  final List<UserProfileData>? data;
  final bool? status;
  final int? code;

  ProfileDataResponse({this.message, this.data, this.status, this.code});

  factory ProfileDataResponse.fromJson(String str) =>
      ProfileDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileDataResponse.fromMap(Map<String, dynamic> json) =>
      ProfileDataResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserProfileData>.from(
                json["data"]!.map((x) => UserProfileData.fromMap(x)),
              ),
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "status": status,
    "code": code,
  };
}

class UserProfileData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;

  UserProfileData({this.id, this.name, this.email, this.phone, this.gender});

  factory UserProfileData.fromJson(String str) =>
      UserProfileData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfileData.fromMap(Map<String, dynamic> json) => UserProfileData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
  };
}
