import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/doctors_data_response_model.dart';
import 'package:tebbi/repositories/doctor_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DoctorsRepository _repository;

  SearchBloc(this._repository) : super(const SearchInitial()) {
    on<SearchStarted>((SearchStarted event, Emitter<SearchState> emit) async {
      emit(const SearchLoading());
      try {
        final DoctorsDataResponse response = await _repository
            .searchDoctors(event.query)
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(SearchSuccess(data: response));
      } on Exception catch (_) {
        emit(const SearchFailure());
      }
    });
  }
}
