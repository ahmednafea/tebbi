part of 'user_on_device_status_bloc.dart';

abstract class UserOnDeviceStatusState extends Equatable {
  const UserOnDeviceStatusState();
  
  @override
  List<Object> get props => <Object>[];
}

class UserOnDeviceStatusInitial extends UserOnDeviceStatusState {
  const UserOnDeviceStatusInitial();
}

class UserOnDeviceStatusCheckInProgress extends UserOnDeviceStatusState {
  const UserOnDeviceStatusCheckInProgress();
}

class UserOnDeviceStatusChangedState extends UserOnDeviceStatusState {
  final UserOnDeviceStatus status;
  
  final String? email;
  final String? password;
  final bool? userHasEnabledFaceID;

  const UserOnDeviceStatusChangedState(
    this.status, {
    this.email,
    this.password,
    this.userHasEnabledFaceID,
  });


  @override
  List<Object> get props => <Object>[status];
}