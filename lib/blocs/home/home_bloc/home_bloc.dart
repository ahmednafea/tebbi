import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/specialization_data_response_model.dart';
import 'package:tebbi/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<HomeStarted>((HomeStarted event, Emitter<HomeState> emit) async {
      emit(const HomeLoading());
      try {
        final SpecializationDataResponse response = await _repository
            .getHome()
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(HomeSuccess(data: response));
      } on Exception catch (_) {
        emit(const HomeFailure());
      }
    });
  }
}
