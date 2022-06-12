part of 'series_search_bloc.dart';

abstract class SeriesSearchEvent extends Equatable {
  const SeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class QuerySeriesChanged extends SeriesSearchEvent {
  final String query;

  QuerySeriesChanged(this.query);

  @override
  List<Object> get props => [query];
}
