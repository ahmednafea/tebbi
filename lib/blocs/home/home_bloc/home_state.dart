part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => <Object>[];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final SpecializationDataResponse data;
  const HomeSuccess({required this.data});
}

class HomeFailure extends HomeState {
  const HomeFailure();
}
