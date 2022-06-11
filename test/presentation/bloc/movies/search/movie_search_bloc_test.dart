import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;

  setUp(
    () {
      mockSearchMovies = MockSearchMovies();
      movieSearchBloc = MovieSearchBloc(mockSearchMovies);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(movieSearchBloc.state, MovieSearchEmpty());
    },
  );

  final tQuery = 'spiderman';

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(QueryChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(QueryChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
