import 'dart:convert';

class CityDataResponse {
  final String? message;
  final List<CityData>? data;
  final bool? status;
  final int? code;

  CityDataResponse({this.message, this.data, this.status, this.code});

  factory CityDataResponse.fromJson(String str) =>
      CityDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityDataResponse.fromMap(Map<String, dynamic> json) =>
      CityDataResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CityData>.from(
                json["data"]!.map((x) => CityData.fromMap(x)),
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

class CityData {
  final int? id;
  final String? name;
  final Governorate? governorate;

  CityData({this.id, this.name, this.governorate});

  factory CityData.fromJson(String str) => CityData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityData.fromMap(Map<String, dynamic> json) => CityData(
    id: json["id"],
    name: json["name"],
    governorate: json["governrate"] == null
        ? null
        : Governorate.fromMap(json["governrate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "governrate": governorate?.toMap(),
  };
}

class Governorate {
  final int? id;
  final String? name;

  Governorate({this.id, this.name});

  factory Governorate.fromJson(String str) =>
      Governorate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Governorate.fromMap(Map<String, dynamic> json) =>
      Governorate(id: json["id"], name: json["name"]);

  Map<String, dynamic> toMap() => {"id": id, "name": name};
}
