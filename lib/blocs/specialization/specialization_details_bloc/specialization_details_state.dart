part of 'specialization_details_bloc.dart';

abstract class SpecializationDetailsState extends Equatable {
  const SpecializationDetailsState();

  @override
  List<Object> get props => <Object>[];
}

class SpecializationDetailsInitial extends SpecializationDetailsState {
  const SpecializationDetailsInitial();
}

class SpecializationDetailsLoading extends SpecializationDetailsState {
  const SpecializationDetailsLoading();
}

class SpecializationDetailsSuccess extends SpecializationDetailsState {
  final SpecializationDetailsDataResponse data;
  const SpecializationDetailsSuccess({required this.data});
}

class SpecializationDetailsFailure extends SpecializationDetailsState {
  const SpecializationDetailsFailure();
}
