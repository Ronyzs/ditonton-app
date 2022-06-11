import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies, MovieTopRatedBloc])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test("initial state should be empty", () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  group(
    'Top rated movies BLoC test',
    () {
      blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedList()),
        expect: () =>
            [MovieTopRatedLoading(), MovieTopRatedHasData(testMovieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );

      blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedList()),
        expect: () =>
            [MovieTopRatedLoading(), MovieTopRatedError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
    },
  );
}
