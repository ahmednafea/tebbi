part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => <Object>[];
}

class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

class AppointmentLoading extends AppointmentState {
  const AppointmentLoading();
}

class AppointmentSuccess extends AppointmentState {
  final AppointmentDataResponse data;
  const AppointmentSuccess({required this.data});
}

class AppointmentFailure extends AppointmentState {
  const AppointmentFailure();
}
