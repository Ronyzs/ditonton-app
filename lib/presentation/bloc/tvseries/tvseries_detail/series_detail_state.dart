part of 'series_detail_bloc.dart';

abstract class SeriesDetailState extends Equatable {
  const SeriesDetailState();

  @override
  List<Object> get props => [];
}

class SeriesDetailEmpty extends SeriesDetailState {}

class SeriesDetailLoading extends SeriesDetailState {}

class SeriesDetailError extends SeriesDetailState {
  final String msg;

  SeriesDetailError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesDetailHasData extends SeriesDetailState {
  final TvSeriesDetail result;

  SeriesDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
