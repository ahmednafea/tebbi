part of 'city_details_bloc.dart';

abstract class CityDetailsEvent extends Equatable {
  const CityDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}

final class CityDetailsStarted extends CityDetailsEvent {
  const CityDetailsStarted({required this.id});

  final int id;

  @override
  List<Object> get props => <Object>[];
}
