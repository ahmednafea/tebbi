import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/appointment_details_data_response_model.dart';
import 'package:tebbi/models/appointment_request_model.dart';
import 'package:tebbi/repositories/appointment_repository.dart';

part 'add_appointment_event.dart';

part 'add_appointment_state.dart';

class AddAppointmentBloc
    extends Bloc<AddAppointmentEvent, AddAppointmentState> {
  final AppointmentsRepository _repository;

  AddAppointmentBloc(this._repository) : super(const AddAppointmentInitial()) {
    on<AddAppointmentStarted>((
      AddAppointmentStarted event,
      Emitter<AddAppointmentState> emit,
    ) async {
      emit(const AddAppointmentLoading());
      try {
        final AppointmentDetailsDataResponseModel response = await _repository
            .addAppointment(event.appointmentRequest)
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(AddAppointmentSuccess(data: response));
      } on Exception catch (_) {
        emit(const AddAppointmentFailure());
      }
    });
  }
}
