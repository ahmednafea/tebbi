import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/city_data_response_model.dart';
import 'package:tebbi/repositories/city_repository.dart';

part 'city_details_event.dart';

part 'city_details_state.dart';

class CityBloc extends Bloc<CityDetailsEvent, CityDetailsState> {
  final CityRepository _repository;

  CityBloc(this._repository) : super(const CityDetailsInitial()) {
    on<CityDetailsStarted>((
      CityDetailsStarted event,
      Emitter<CityDetailsState> emit,
    ) async {
      emit(const CityDetailsLoading());
      try {
        final CityDataResponse response = await _repository
            .getCityDetails(event.id)
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(CityDetailsSuccess(data: response));
      } on Exception catch (_) {
        emit(const CityDetailsFailure());
      }
    });
  }
}
