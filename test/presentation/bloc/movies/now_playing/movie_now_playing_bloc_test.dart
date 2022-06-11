import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([MovieNowPlayingBloc, GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
    },
  );

  group(
    'Now playing movies BLoC test',
    () {
      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return movieNowPlayingBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () =>
            [MovieNowPlayingLoading(), MovieNowPlayingHasData(testMovieList)],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );

      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieNowPlayingBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () =>
            [MovieNowPlayingLoading(), MovieNowPlayingError('Server Failure')],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );
    },
  );
}
