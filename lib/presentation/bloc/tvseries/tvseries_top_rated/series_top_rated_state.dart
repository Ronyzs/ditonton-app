part of 'series_top_rated_bloc.dart';

abstract class SeriesTopRatedState extends Equatable {
  const SeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class SeriesTopRatedEmpty extends SeriesTopRatedState {}

class SeriesTopRatedLoading extends SeriesTopRatedState {}

class SeriesTopRatedError extends SeriesTopRatedState {
  final String msg;

  SeriesTopRatedError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesTopRatedHasData extends SeriesTopRatedState {
  final List<TvSeries> result;

  SeriesTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
