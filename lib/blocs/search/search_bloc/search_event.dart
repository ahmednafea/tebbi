part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SearchStarted extends SearchEvent {
  const SearchStarted(this.query);

  final String query;

  @override
  List<Object> get props => <Object>[];
}
