part of 'series_watchlist_bloc.dart';

abstract class SeriesWatchlistState extends Equatable {
  const SeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class SeriesWatchlistEmpty extends SeriesWatchlistState {}

class SeriesWatchlistLoading extends SeriesWatchlistState {}

class SeriesWatchlistError extends SeriesWatchlistState {
  final String msg;

  SeriesWatchlistError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesWatchlistHasData extends SeriesWatchlistState {
  final List<TvSeries> result;

  SeriesWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertSeriesWatchlist extends SeriesWatchlistState {
  final bool status;

  InsertSeriesWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistSeriesMessage extends SeriesWatchlistState {
  final String msg;

  WatchlistSeriesMessage(this.msg);

  @override
  List<Object> get props => [msg];
}
