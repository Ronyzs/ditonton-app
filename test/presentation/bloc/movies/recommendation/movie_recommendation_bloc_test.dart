import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([MovieRecommendationBloc, GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(
    () {
      mockGetMovieRecommendations = MockGetMovieRecommendations();
      movieRecommendationBloc =
          MovieRecommendationBloc(mockGetMovieRecommendations);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
    },
  );

  group(
    'Recommendation movies BLoC test',
    () {
      blocTest<MovieRecommendationBloc, MovieRecommendationState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(testMovieDetail.id))
              .thenAnswer((_) async => Right(testMovieList));
          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(FetchMovieRecommendation(testMovieDetail.id)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationHasData(testMovieList)
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(testMovieDetail.id));
        },
      );

      blocTest<MovieRecommendationBloc, MovieRecommendationState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetMovieRecommendations.execute(testMovieDetail.id))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(FetchMovieRecommendation(testMovieDetail.id)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(testMovieDetail.id));
        },
      );
    },
  );
}
