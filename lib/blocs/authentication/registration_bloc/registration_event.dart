part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => <Object>[];
}

final class RegistrationStarted extends RegistrationEvent {
  final RegistrationRequest request;

  const RegistrationStarted({required this.request});

  @override
  List<Object> get props => <Object>[request.toJson()];
}
