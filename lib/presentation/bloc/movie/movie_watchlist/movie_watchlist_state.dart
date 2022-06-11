part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String msg;

  MovieWatchlistError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;

  MovieWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertWatchlist extends MovieWatchlistState {
  final bool status;

  InsertWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistMessage extends MovieWatchlistState {
  final String msg;

  WatchlistMessage(this.msg);

  @override
  List<Object> get props => [msg];
}
