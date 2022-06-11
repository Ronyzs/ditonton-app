part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularEmpty extends MoviePopularState {}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularError extends MoviePopularState {
  final String msg;

  MoviePopularError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> result;

  MoviePopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
