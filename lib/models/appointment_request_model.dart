import 'dart:convert';

class AppointmentRequest {
  final int doctorId;
  final String startTime;
  final String notes;

  AppointmentRequest({
    required this.doctorId,
    required this.startTime,
    required this.notes,
  });

  factory AppointmentRequest.fromJson(String str) =>
      AppointmentRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentRequest.fromMap(Map<String, dynamic> json) =>
      AppointmentRequest(
        doctorId: json["doctor_id"],
        startTime: json["start_time"],
        notes: json["notes"],
      );

  Map<String, dynamic> toMap() => {
    "doctor_id": doctorId,
    "start_time": startTime,
    "notes": notes,
  };
}
