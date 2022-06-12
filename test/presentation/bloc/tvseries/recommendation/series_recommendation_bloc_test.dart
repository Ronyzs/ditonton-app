import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_recommendation/series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([SeriesRecommendationBloc, GetTvSeriesRecommendations])
void main() {
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late SeriesRecommendationBloc seriesRecommendationBloc;

  setUp(
    () {
      mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
      seriesRecommendationBloc =
          SeriesRecommendationBloc(mockGetTvSeriesRecommendations);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(seriesRecommendationBloc.state, SeriesRecommendationEmpty());
    },
  );

  group(
    'Recommendation movies BLoC test',
    () {
      blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetTvSeriesRecommendations.execute(testTvSeriesDetail.id))
              .thenAnswer((_) async => Right(testTvSeriesList));
          return seriesRecommendationBloc;
        },
        act: (bloc) =>
            bloc.add(FetchSeriesRecommendation(testTvSeriesDetail.id)),
        expect: () => [
          SeriesRecommendationLoading(),
          SeriesRecommendationHasData(testTvSeriesList)
        ],
        verify: (bloc) {
          verify(mockGetTvSeriesRecommendations.execute(testTvSeriesDetail.id));
        },
      );

      blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetTvSeriesRecommendations.execute(testTvSeriesDetail.id))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return seriesRecommendationBloc;
        },
        act: (bloc) =>
            bloc.add(FetchSeriesRecommendation(testTvSeriesDetail.id)),
        expect: () => [
          SeriesRecommendationLoading(),
          SeriesRecommendationError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTvSeriesRecommendations.execute(testTvSeriesDetail.id));
        },
      );
    },
  );
}
