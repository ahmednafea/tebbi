part of 'user_on_device_status_bloc.dart';

abstract class UserOnDeviceStatusEvent extends Equatable {
  const UserOnDeviceStatusEvent();

  @override
  List<Object> get props => <Object>[];
}

class UserOnDeviceStatusCheckStarted extends UserOnDeviceStatusEvent {
  const UserOnDeviceStatusCheckStarted();
}

class UserOnDeviceStatusChanged extends UserOnDeviceStatusEvent {
  const UserOnDeviceStatusChanged(this.status);

  final UserOnDeviceStatus status;

  @override
  List<Object> get props => <Object>[status];
}
