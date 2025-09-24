import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/governate_data_response_model.dart';
import 'package:tebbi/repositories/governorate_repository.dart';

part 'governorate_event.dart';

part 'governorate_state.dart';

class GovernorateBloc extends Bloc<GovernorateEvent, GovernorateState> {
  final GovernorateRepository _repository;

  GovernorateBloc(this._repository) : super(const GovernorateInitial()) {
    on<GovernorateStarted>((
      GovernorateStarted event,
      Emitter<GovernorateState> emit,
    ) async {
      emit(const GovernorateLoading());
      try {
        final GovernorateDataResponse response = await _repository
            .getGovernoratesList()
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(GovernorateSuccess(data: response));
      } on Exception catch (_) {
        emit(const GovernorateFailure());
      }
    });
  }
}
