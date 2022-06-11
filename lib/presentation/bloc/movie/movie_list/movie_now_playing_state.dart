part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingEmpty extends MovieNowPlayingState {}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String msg;

  MovieNowPlayingError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> result;

  MovieNowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
