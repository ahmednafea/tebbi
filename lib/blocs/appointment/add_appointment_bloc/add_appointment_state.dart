part of 'add_appointment_bloc.dart';

abstract class AddAppointmentState extends Equatable {
  const AddAppointmentState();

  @override
  List<Object> get props => <Object>[];
}

class AddAppointmentInitial extends AddAppointmentState {
  const AddAppointmentInitial();
}

class AddAppointmentLoading extends AddAppointmentState {
  const AddAppointmentLoading();
}

class AddAppointmentSuccess extends AddAppointmentState {
  final AppointmentDetailsDataResponseModel data;
  const AddAppointmentSuccess({required this.data});
}

class AddAppointmentFailure extends AddAppointmentState {
  const AddAppointmentFailure();
}
