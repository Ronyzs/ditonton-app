part of 'series_detail_bloc.dart';

abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchSeriesDetail extends SeriesDetailEvent {
  final int id;

  FetchSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}
