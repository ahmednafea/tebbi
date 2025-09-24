import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/repositories/authentication_repository.dart';
import 'package:tebbi/shared/utilities/local_storage_utility.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthenticationRepository _authenticationRepository;

  LogoutBloc(this._authenticationRepository) : super(const LogoutInitial()) {
    on<LogoutStarted>((LogoutStarted event, Emitter<LogoutState> emit) async {
      emit(const LogoutLoading());
      try {
        await _authenticationRepository.logout().catchError((
          Object? error,
          StackTrace stackTrace,
        ) {
          throw error is Exception ? error : Exception();
        });
        LocalStorageUtility.deleteUserTokens();
        await LocalStorageUtility.setUserExistsOnDevice(value: false);
        await LocalStorageUtility.deleteUserEmail();
        await LocalStorageUtility.deleteUserPassword();
        emit(LogoutSuccess());
      } on Exception catch (_) {
        emit(const LogoutFailure());
      }
    });
  }
}
