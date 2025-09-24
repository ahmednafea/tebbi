part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => <Object>[];
}

final class LoginStarted extends LoginEvent {
  final LoginRequest request;

  const LoginStarted({required this.request});

  @override
  List<Object> get props => <Object>[request.toJson()];
}
