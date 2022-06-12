part of 'series_now_playing_bloc.dart';

abstract class SeriesNowPlayingState extends Equatable {
  const SeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

class SeriesNowPlayingEmpty extends SeriesNowPlayingState {}

class SeriesNowPlayingLoading extends SeriesNowPlayingState {}

class SeriesNowPlayingError extends SeriesNowPlayingState {
  final String msg;

  SeriesNowPlayingError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesNowPlayingHasData extends SeriesNowPlayingState {
  final List<TvSeries> result;

  SeriesNowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
