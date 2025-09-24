part of 'specialization_bloc.dart';

abstract class SpecializationEvent extends Equatable {
  const SpecializationEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SpecializationStarted extends SpecializationEvent {
  const SpecializationStarted();

  @override
  List<Object> get props => <Object>[];
}
