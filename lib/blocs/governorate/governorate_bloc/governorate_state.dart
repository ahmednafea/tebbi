part of 'governorate_bloc.dart';

abstract class GovernorateState extends Equatable {
  const GovernorateState();

  @override
  List<Object> get props => <Object>[];
}

class GovernorateInitial extends GovernorateState {
  const GovernorateInitial();
}

class GovernorateLoading extends GovernorateState {
  const GovernorateLoading();
}

class GovernorateSuccess extends GovernorateState {
  final GovernorateDataResponse data;
  const GovernorateSuccess({required this.data});
}

class GovernorateFailure extends GovernorateState {
  const GovernorateFailure();
}
