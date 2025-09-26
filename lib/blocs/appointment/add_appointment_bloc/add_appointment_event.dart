part of 'add_appointment_bloc.dart';

abstract class AddAppointmentEvent extends Equatable {
  const AddAppointmentEvent();

  @override
  List<Object> get props => <Object>[];
}

final class AddAppointmentStarted extends AddAppointmentEvent {
  const AddAppointmentStarted({required this.appointmentRequest});

  final AppointmentRequest appointmentRequest;

  @override
  List<Object> get props => <Object>[];
}
