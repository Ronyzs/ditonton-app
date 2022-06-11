import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([MoviePopularBloc, GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(
    () {
      mockGetPopularMovies = MockGetPopularMovies();
      moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(moviePopularBloc.state, MoviePopularEmpty());
    },
  );

  group(
    'Popular movies BLoC test',
    () {
      blocTest<MoviePopularBloc, MoviePopularState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(FetchPopularList()),
        expect: () =>
            [MoviePopularLoading(), MoviePopularHasData(testMovieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );

      blocTest<MoviePopularBloc, MoviePopularState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(FetchPopularList()),
        expect: () =>
            [MoviePopularLoading(), MoviePopularError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );
    },
  );
}
