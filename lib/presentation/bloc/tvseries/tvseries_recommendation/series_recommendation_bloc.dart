import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_recommendation_event.dart';
part 'series_recommendation_state.dart';

class SeriesRecommendationBloc
    extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  SeriesRecommendationBloc(this.getTvSeriesRecommendations)
      : super(SeriesRecommendationEmpty()) {
    on<FetchSeriesRecommendation>(
      (event, emit) async {
        emit(SeriesRecommendationLoading());

        final result = await getTvSeriesRecommendations.execute(event.id);
        result.fold(
          (failure) => emit(SeriesRecommendationError(failure.message)),
          (data) => emit(SeriesRecommendationHasData(data)),
        );
      },
    );
  }
}
