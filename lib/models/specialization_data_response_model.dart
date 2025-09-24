import 'dart:convert';

class SpecializationDataResponse {
  final String? message;
  final List<SpecializationData>? data;
  final bool? status;
  final int? code;

  SpecializationDataResponse({this.message, this.data, this.status, this.code});

  factory SpecializationDataResponse.fromJson(String str) =>
      SpecializationDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpecializationDataResponse.fromMap(Map<String, dynamic> json) =>
      SpecializationDataResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SpecializationData>.from(
                json["data"]!.map((x) => SpecializationData.fromMap(x)),
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

class SpecializationData {
  final int? id;
  final String? name;
  final List<Doctor>? doctors;

  SpecializationData({this.id, this.name, this.doctors});

  factory SpecializationData.fromJson(String str) =>
      SpecializationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpecializationData.fromMap(Map<String, dynamic> json) =>
      SpecializationData(
        id: json["id"],
        name: json["name"],
        doctors: json["doctors"] == null
            ? []
            : List<Doctor>.from(json["doctors"]!.map((x) => Doctor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "doctors": doctors == null
        ? []
        : List<dynamic>.from(doctors!.map((x) => x.toMap())),
  };
}

class Doctor {
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
  final StartTime? startTime;
  final EndTime? endTime;

  Doctor({
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

  factory Doctor.fromJson(String str) => Doctor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
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
    startTime: startTimeValues.map[json["start_time"]]!,
    endTime: endTimeValues.map[json["end_time"]]!,
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
    "start_time": startTimeValues.reverse[startTime],
    "end_time": endTimeValues.reverse[endTime],
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

enum Degree { CONSULTANT, PROFESSOR, SPECIALIST }

final degreeValues = EnumValues({
  "Consultant": Degree.CONSULTANT,
  "Professor": Degree.PROFESSOR,
  "Specialist": Degree.SPECIALIST,
});

enum EndTime { THE_200000_PM }

final endTimeValues = EnumValues({"20:00:00 PM": EndTime.THE_200000_PM});

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

enum StartTime { THE_140000_PM }

final startTimeValues = EnumValues({"14:00:00 PM": StartTime.THE_140000_PM});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
