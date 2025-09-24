part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();

  @override
  List<Object> get props => <Object>[];
}
