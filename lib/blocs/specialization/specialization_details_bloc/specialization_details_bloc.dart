import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/specialization_details_data_response.dart';
import 'package:tebbi/repositories/specializations_repository.dart';

part 'specialization_details_event.dart';
part 'specialization_details_state.dart';

class SpecializationBloc
    extends Bloc<SpecializationDetailsEvent, SpecializationDetailsState> {
  final SpecializationsRepository _repository;

  SpecializationBloc(this._repository)
    : super(const SpecializationDetailsInitial()) {
    on<SpecializationDetailsStarted>((
      SpecializationDetailsStarted event,
      Emitter<SpecializationDetailsState> emit,
    ) async {
      emit(const SpecializationDetailsLoading());
      try {
        final SpecializationDetailsDataResponse response = await _repository
            .getSpecializationDetails(event.id)
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(SpecializationDetailsSuccess(data: response));
      } on Exception catch (_) {
        emit(const SpecializationDetailsFailure());
      }
    });
  }
}
