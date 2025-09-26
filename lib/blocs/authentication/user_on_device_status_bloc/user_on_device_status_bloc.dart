import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebbi/shared/utilities/local_storage_utility.dart';

part 'user_on_device_status_event.dart';

part 'user_on_device_status_state.dart';

enum UserOnDeviceStatus { doesntExist, exists }

class UserOnDeviceStatusBloc
    extends Bloc<UserOnDeviceStatusEvent, UserOnDeviceStatusState> {
  UserOnDeviceStatusBloc() : super(const UserOnDeviceStatusInitial()) {
    on<UserOnDeviceStatusCheckStarted>((
      UserOnDeviceStatusCheckStarted event,
      Emitter<UserOnDeviceStatusState> emit,
    ) async {
      emit(const UserOnDeviceStatusCheckInProgress());

      final String? userEmail = await LocalStorageUtility.userEmail;
      final String? userPassword = await LocalStorageUtility.userPassword;

      final bool userExistsOnDevice =
          await LocalStorageUtility.userExistsOnDevice;

      if (!userExistsOnDevice) {
        emit(
          const UserOnDeviceStatusChangedState(UserOnDeviceStatus.doesntExist),
        );
        return;
      }
      emit(
        UserOnDeviceStatusChangedState(
          UserOnDeviceStatus.exists,
          email: userEmail,
          password: userPassword,
        ),
      );
    });
    on<UserOnDeviceStatusChanged>((
      UserOnDeviceStatusChanged event,
      Emitter<UserOnDeviceStatusState> emit,
    ) {
      emit(UserOnDeviceStatusChangedState(event.status));
    });
  }
}
