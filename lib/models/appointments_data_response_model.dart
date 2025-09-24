import 'dart:convert';

class AppointmentDataResponse {
  final String? message;
  final List<AppointmentData>? data;
  final bool? status;
  final int? code;

  AppointmentDataResponse({this.message, this.data, this.status, this.code});

  factory AppointmentDataResponse.fromJson(String str) =>
      AppointmentDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentDataResponse.fromMap(Map<String, dynamic> json) =>
      AppointmentDataResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AppointmentData>.from(
                json["data"]!.map((x) => AppointmentData.fromMap(x)),
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

class AppointmentData {
  final int? id;
  final Doctor? doctor;
  final Patient? patient;
  final String? appointmentTime;
  final String? appointmentEndTime;
  final String? status;
  final String? notes;
  final int? appointmentPrice;

  AppointmentData({
    this.id,
    this.doctor,
    this.patient,
    this.appointmentTime,
    this.appointmentEndTime,
    this.status,
    this.notes,
    this.appointmentPrice,
  });

  factory AppointmentData.fromJson(String str) =>
      AppointmentData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentData.fromMap(Map<String, dynamic> json) => AppointmentData(
    id: json["id"],
    doctor: json["doctor"] == null ? null : Doctor.fromMap(json["doctor"]),
    patient: json["patient"] == null ? null : Patient.fromMap(json["patient"]),
    appointmentTime: json["appointment_time"],
    appointmentEndTime: json["appointment_end_time"],
    status: json["status"],
    notes: json["notes"],
    appointmentPrice: json["appointment_price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "doctor": doctor?.toMap(),
    "patient": patient?.toMap(),
    "appointment_time": appointmentTime,
    "appointment_end_time": appointmentEndTime,
    "status": status,
    "notes": notes,
    "appointment_price": appointmentPrice,
  };
}

class Doctor {
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

class Patient {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;

  Patient({this.id, this.name, this.email, this.phone, this.gender});

  factory Patient.fromJson(String str) => Patient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
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
