import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/specialization_data_response_model.dart';
import 'package:tebbi/repositories/specializations_repository.dart';

part 'specialization_event.dart';
part 'specialization_state.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  final SpecializationsRepository _repository;

  SpecializationBloc(this._repository) : super(const SpecializationInitial()) {
    on<SpecializationStarted>((
      SpecializationStarted event,
      Emitter<SpecializationState> emit,
    ) async {
      emit(const SpecializationLoading());
      try {
        final SpecializationDataResponse response = await _repository
            .getSpecializations()
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(SpecializationSuccess(data: response));
      } on Exception catch (_) {
        emit(const SpecializationFailure());
      }
    });
  }
}
