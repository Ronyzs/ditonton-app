part of 'series_search_bloc.dart';

abstract class SeriesSearchState extends Equatable {
  const SeriesSearchState();

  @override
  List<Object> get props => [];
}

class SeriesSearchEmpty extends SeriesSearchState {}

class SeriesSearchLoading extends SeriesSearchState {}

class SeriesSearchError extends SeriesSearchState {
  final String msg;

  SeriesSearchError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesSearchHasData extends SeriesSearchState {
  final List<TvSeries> result;

  SeriesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
