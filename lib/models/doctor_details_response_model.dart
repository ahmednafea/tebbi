import 'dart:convert';

class DoctorDetailsDataResponse {
  final String? message;
  final DoctorData? data;
  final bool? status;
  final int? code;

  DoctorDetailsDataResponse({this.message, this.data, this.status, this.code});

  factory DoctorDetailsDataResponse.fromJson(String str) =>
      DoctorDetailsDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorDetailsDataResponse.fromMap(Map<String, dynamic> json) =>
      DoctorDetailsDataResponse(
        message: json["message"],
        data: json["data"] == null ? null : DoctorData.fromMap(json["data"]),
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

class DoctorData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? gender;
  final String? address;
  final String? description;
  final String? degree;
  final Specialization? specialization;
  final City? city;
  final int? appointPrice;
  final String? startTime;
  final String? endTime;

  DoctorData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.address,
    this.description,
    this.degree,
    this.specialization,
    this.city,
    this.appointPrice,
    this.startTime,
    this.endTime,
  });

  factory DoctorData.fromJson(String str) =>
      DoctorData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorData.fromMap(Map<String, dynamic> json) => DoctorData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    gender: json["gender"],
    address: json["address"],
    description: json["description"],
    degree: json["degree"],
    specialization: json["specialization"] == null
        ? null
        : Specialization.fromMap(json["specialization"]),
    city: json["city"] == null ? null : City.fromMap(json["city"]),
    appointPrice: json["appoint_price"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "gender": gender,
    "address": address,
    "description": description,
    "degree": degree,
    "specialization": specialization?.toMap(),
    "city": city?.toMap(),
    "appoint_price": appointPrice,
    "start_time": startTime,
    "end_time": endTime,
  };
}

class City {
  final int? id;
  final String? name;
  final Specialization? governrate;

  City({this.id, this.name, this.governrate});

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    governrate: json["governrate"] == null
        ? null
        : Specialization.fromMap(json["governrate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "governrate": governrate?.toMap(),
  };
}

class Specialization {
  final int? id;
  final String? name;

  Specialization({this.id, this.name});

  factory Specialization.fromJson(String str) =>
      Specialization.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Specialization.fromMap(Map<String, dynamic> json) =>
      Specialization(id: json["id"], name: json["name"]);

  Map<String, dynamic> toMap() => {"id": id, "name": name};
}
