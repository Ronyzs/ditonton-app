part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends MovieWatchlistEvent {
  @override
  List<Object> get props => [];
}

class LoadWatchlistStatusMovie extends MovieWatchlistEvent {
  final int id;

  LoadWatchlistStatusMovie(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movie;

  InsertWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movie;

  DeleteWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}
