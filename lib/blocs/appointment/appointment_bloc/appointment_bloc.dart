import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/appointments_data_response_model.dart';
import 'package:tebbi/repositories/appointment_repository.dart';

part 'appointment_event.dart';

part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentsRepository _repository;

  AppointmentBloc(this._repository) : super(const AppointmentInitial()) {
    on<AppointmentStarted>((
      AppointmentStarted event,
      Emitter<AppointmentState> emit,
    ) async {
      emit(const AppointmentLoading());
      try {
        final AppointmentDataResponse response = await _repository
            .getAppointments()
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(AppointmentSuccess(data: response));
      } on Exception catch (_) {
        emit(const AppointmentFailure());
      }
    });
  }
}
