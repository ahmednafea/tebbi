import 'dart:convert';

class UpdateProfileRequest {
  final String name;
  final String email;
  final String phone;
  final int gender;
  final String password;

  UpdateProfileRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
  });

  factory UpdateProfileRequest.fromJson(String str) =>
      UpdateProfileRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProfileRequest.fromMap(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "password": password,
  };
}
