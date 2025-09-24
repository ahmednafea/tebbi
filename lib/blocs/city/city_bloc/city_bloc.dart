import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/city_data_response_model.dart';
import 'package:tebbi/repositories/city_repository.dart';

part 'city_event.dart';

part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository _repository;

  CityBloc(this._repository) : super(const CityInitial()) {
    on<CityStarted>((CityStarted event, Emitter<CityState> emit) async {
      emit(const CityLoading());
      try {
        final CityDataResponse response = await _repository
            .getCities()
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(CitySuccess(data: response));
      } on Exception catch (_) {
        emit(const CityFailure());
      }
    });
  }
}
