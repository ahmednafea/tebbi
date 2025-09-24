part of 'specialization_bloc.dart';

abstract class SpecializationState extends Equatable {
  const SpecializationState();

  @override
  List<Object> get props => <Object>[];
}

class SpecializationInitial extends SpecializationState {
  const SpecializationInitial();
}

class SpecializationLoading extends SpecializationState {
  const SpecializationLoading();
}

class SpecializationSuccess extends SpecializationState {
  final SpecializationDataResponse data;
  const SpecializationSuccess({required this.data});
}

class SpecializationFailure extends SpecializationState {
  const SpecializationFailure();
}
