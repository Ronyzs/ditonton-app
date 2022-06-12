part of 'series_recommendation_bloc.dart';

abstract class SeriesRecommendationEvent extends Equatable {
  const SeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchSeriesRecommendation extends SeriesRecommendationEvent {
  final int id;

  FetchSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
