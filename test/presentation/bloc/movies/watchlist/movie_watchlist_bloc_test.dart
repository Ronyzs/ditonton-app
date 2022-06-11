import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  group('Watchlist list BLoC movie testing', () {
    test('initial state should be empty', () {
      expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
    });

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, HasData] when data loaded successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return FetchWatchlistMovie().props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistError('Server Failure'),
      ],
      verify: (bloc) => MovieWatchlistLoading(),
    );
  });

  group('Watchlist Status BLoC movie testing', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, HasData] when data loaded successfully',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusMovie(testMovieDetail.id)),
      expect: () => [InsertWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        return LoadWatchlistStatusMovie(testMovieDetail.id).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusMovie(testMovieDetail.id)),
      expect: () => [InsertWatchlist(false)],
      verify: (bloc) => MovieWatchlistLoading(),
    );
  });

  group('Adding watchlist movie BLoC testing', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, HasData] when data loaded successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieWatchlistLoading(),
        WatchlistMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return InsertWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieWatchlistLoading(),
        MovieWatchlistError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistMovie(testMovieDetail),
    );
  });

  group('Remove watchlist movie BLoC testing', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, HasData] when data is loaded successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMessage('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return DeleteWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieWatchlistError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistMovie(testMovieDetail),
    );
  });
}
