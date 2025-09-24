part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => <Object>[];
}

class CityInitial extends CityState {
  const CityInitial();
}

class CityLoading extends CityState {
  const CityLoading();
}

class CitySuccess extends CityState {
  final CityDataResponse data;
  const CitySuccess({required this.data});
}

class CityFailure extends CityState {
  const CityFailure();
}
