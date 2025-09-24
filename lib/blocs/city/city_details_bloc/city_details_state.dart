part of 'city_details_bloc.dart';

abstract class CityDetailsState extends Equatable {
  const CityDetailsState();

  @override
  List<Object> get props => <Object>[];
}

class CityDetailsInitial extends CityDetailsState {
  const CityDetailsInitial();
}

class CityDetailsLoading extends CityDetailsState {
  const CityDetailsLoading();
}

class CityDetailsSuccess extends CityDetailsState {
  final CityDataResponse data;
  const CityDetailsSuccess({required this.data});
}

class CityDetailsFailure extends CityDetailsState {
  const CityDetailsFailure();
}
