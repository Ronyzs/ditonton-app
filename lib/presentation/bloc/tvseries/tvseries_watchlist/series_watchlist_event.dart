part of 'series_watchlist_bloc.dart';

abstract class SeriesWatchlistEvent extends Equatable {
  const SeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistSeries extends SeriesWatchlistEvent {
  @override
  List<Object> get props => [];
}

class LoadWatchlistStatusSeries extends SeriesWatchlistEvent {
  final int id;

  LoadWatchlistStatusSeries(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistSeries extends SeriesWatchlistEvent {
  final TvSeriesDetail series;

  InsertWatchlistSeries(this.series);

  @override
  List<Object> get props => [series];
}

class DeleteWatchlistSeries extends SeriesWatchlistEvent {
  final TvSeriesDetail series;

  DeleteWatchlistSeries(this.series);

  @override
  List<Object> get props => [series];
}
