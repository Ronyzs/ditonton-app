part of 'series_recommendation_bloc.dart';

abstract class SeriesRecommendationState extends Equatable {
  const SeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class SeriesRecommendationEmpty extends SeriesRecommendationState {}

class SeriesRecommendationLoading extends SeriesRecommendationState {}

class SeriesRecommendationError extends SeriesRecommendationState {
  final String msg;

  SeriesRecommendationError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SeriesRecommendationHasData extends SeriesRecommendationState {
  final List<TvSeries> result;

  SeriesRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
