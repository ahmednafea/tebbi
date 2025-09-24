part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => <Object>[];
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

class RegistrationLoading extends RegistrationState {
  const RegistrationLoading();
}

class RegistrationSuccess extends RegistrationState {
  final AuthenticationResponse data;
  const RegistrationSuccess({required this.data});
}

class RegistrationFailure extends RegistrationState {
  const RegistrationFailure();
}
