import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/profile_data_response_model.dart';
import 'package:tebbi/repositories/user_repository.dart';

part 'user_profile_event.dart';

part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository _repository;

  UserProfileBloc(this._repository) : super(const UserProfileInitial()) {
    on<UserProfileStarted>((
      UserProfileStarted event,
      Emitter<UserProfileState> emit,
    ) async {
      emit(const UserProfileLoading());
      try {
        final ProfileDataResponse response = await _repository
            .getUserProfile()
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(UserProfileSuccess(data: response));
      } on Exception catch (_) {
        emit(const UserProfileFailure());
      }
    });
  }
}
