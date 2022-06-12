part of 'series_now_playing_bloc.dart';

abstract class SeriesNowPlayingEvent extends Equatable {
  const SeriesNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingSeries extends SeriesNowPlayingEvent {
  @override
  List<Object> get props => [];
}
