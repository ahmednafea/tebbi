part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => <Object>[];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  final DoctorsDataResponse data;
  const SearchSuccess({required this.data});
}

class SearchFailure extends SearchState {
  const SearchFailure();
}
