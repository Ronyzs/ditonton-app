part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String msg;

  MovieDetailError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;

  MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
