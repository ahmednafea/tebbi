import 'dart:convert';

class RegistrationRequest {
  final String name;
  final String email;
  final String phone;
  final int gender;
  final String password;
  final String passwordConfirmation;

  RegistrationRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegistrationRequest.fromJson(String str) =>
      RegistrationRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegistrationRequest.fromMap(Map<String, dynamic> json) =>
      RegistrationRequest(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
