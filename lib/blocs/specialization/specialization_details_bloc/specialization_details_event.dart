part of 'specialization_details_bloc.dart';

abstract class SpecializationDetailsEvent extends Equatable {
  const SpecializationDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SpecializationDetailsStarted extends SpecializationDetailsEvent {
  const SpecializationDetailsStarted({required this.id});

  final int id;

  @override
  List<Object> get props => <Object>[];
}
