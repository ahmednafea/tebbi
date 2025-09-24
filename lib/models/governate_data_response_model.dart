import 'dart:convert';

class GovernorateDataResponse {
  final String? message;
  final List<GovernorateData>? data;
  final bool? status;
  final int? code;

  GovernorateDataResponse({this.message, this.data, this.status, this.code});

  factory GovernorateDataResponse.fromJson(String str) =>
      GovernorateDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GovernorateDataResponse.fromMap(Map<String, dynamic> json) =>
      GovernorateDataResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GovernorateData>.from(
                json["data"]!.map((x) => GovernorateData.fromMap(x)),
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

class GovernorateData {
  final int? id;
  final String? name;

  GovernorateData({this.id, this.name});

  factory GovernorateData.fromJson(String str) =>
      GovernorateData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GovernorateData.fromMap(Map<String, dynamic> json) =>
      GovernorateData(id: json["id"], name: json["name"]);

  Map<String, dynamic> toMap() => {"id": id, "name": name};
}
