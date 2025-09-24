part of 'governorate_bloc.dart';

abstract class GovernorateEvent extends Equatable {
  const GovernorateEvent();

  @override
  List<Object> get props => <Object>[];
}

final class GovernorateStarted extends GovernorateEvent {
  const GovernorateStarted();

  @override
  List<Object> get props => <Object>[];
}
