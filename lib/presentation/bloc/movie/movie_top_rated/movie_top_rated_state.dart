part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedEmpty extends MovieTopRatedState {}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedError extends MovieTopRatedState {
  final String msg;

  MovieTopRatedError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
