part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends MovieSearchEvent {
  final String query;

  QueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
