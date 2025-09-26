import 'dart:convert';

class DoctorsDataResponse {
  final String? message;
  final List<DoctorData>? data;
  final bool? status;
  final int? code;

  DoctorsDataResponse({this.message, this.data, this.status, this.code});

  factory DoctorsDataResponse.fromJson(String str) =>
      DoctorsDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorsDataResponse.fromMap(Map<String, dynamic> json) =>
      DoctorsDataResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DoctorData>.from(
                json["data"]!.map((x) => DoctorData.fromMap(x)),
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

class DoctorData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final Gender? gender;
  final String? address;
  final String? description;
  final Degree? degree;
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
    gender: genderValues.map[json["gender"]]!,
    address: json["address"],
    description: json["description"],
    degree: degreeValues.map[json["degree"]]!,
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
    "gender": genderValues.reverse[gender],
    "address": address,
    "description": description,
    "degree": degreeValues.reverse[degree],
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
  final Specialization? governorate;

  City({this.id, this.name, this.governorate});

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    governorate: json["governrate"] == null
        ? null
        : Specialization.fromMap(json["governrate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "governrate": governorate?.toMap(),
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

enum Degree { CONSULTANT, PROFESSOR, SPECIALIST }

final degreeValues = EnumValues({
  "Consultant": Degree.CONSULTANT,
  "Professor": Degree.PROFESSOR,
  "Specialist": Degree.SPECIALIST,
});

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
