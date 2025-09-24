part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => <Object>[];
}

final class CityStarted extends CityEvent {
  const CityStarted();

  @override
  List<Object> get props => <Object>[];
}
