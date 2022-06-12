part of 'series_popular_bloc.dart';

abstract class SeriesPopularState extends Equatable {
  const SeriesPopularState();

  @override
  List<Object> get props => [];
}

class SeriesPopularEmpty extends SeriesPopularState {}

class SeriesPopularLoading extends SeriesPopularState {}

class SeriesPopularError extends SeriesPopularState {
  final String msg;

  SeriesPopularError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesPopularHasData extends SeriesPopularState {
  final List<TvSeries> result;

  SeriesPopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
