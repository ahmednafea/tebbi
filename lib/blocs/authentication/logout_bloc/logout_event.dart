part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => <Object>[];
}

final class LogoutStarted extends LogoutEvent {
  const LogoutStarted();

  @override
  List<Object> get props => <Object>[];
}
