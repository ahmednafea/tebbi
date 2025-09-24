import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/models/profile_data_response_model.dart';
import 'package:tebbi/models/update_profile_request_model.dart';
import 'package:tebbi/repositories/user_repository.dart';

part 'update_user_profile_event.dart';

part 'update_user_profile_state.dart';

class UpdateUserProfileBloc
    extends Bloc<UpdateUserProfileEvent, UpdateUserProfileState> {
  final UserRepository _repository;

  UpdateUserProfileBloc(this._repository)
    : super(const UpdateUserProfileInitial()) {
    on<UpdateUserProfileStarted>((
      UpdateUserProfileStarted event,
      Emitter<UpdateUserProfileState> emit,
    ) async {
      emit(const UpdateUserProfileLoading());
      try {
        final ProfileDataResponse response = await _repository
            .updateProfile(request: event.request)
            .catchError((Object? error, StackTrace stackTrace) {
              throw error is Exception ? error : Exception();
            });
        emit(UpdateUserProfileSuccess(data: response));
      } on Exception catch (_) {
        emit(const UserProfileFailure());
      }
    });
  }
}
