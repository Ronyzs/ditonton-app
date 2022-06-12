import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_watchlist/series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetTvSeriesWatchListStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late SeriesWatchlistBloc seriesWatchlistBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetTvSeriesWatchListStatus mockGetTvSeriesWatchListStatus;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetTvSeriesWatchListStatus = MockGetTvSeriesWatchListStatus();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
    seriesWatchlistBloc = SeriesWatchlistBloc(
      mockGetWatchlistTvSeries,
      mockGetTvSeriesWatchListStatus,
      mockSaveTvSeriesWatchlist,
      mockRemoveTvSeriesWatchlist,
    );
  });

  group('TV Series Watchlist BLoC testing', () {
    test('initial state should be empty', () {
      expect(seriesWatchlistBloc.state, SeriesWatchlistEmpty());
    });

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data loaded successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistSeries()),
      expect: () => [
        SeriesWatchlistLoading(),
        SeriesWatchlistHasData(testTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
        return FetchWatchlistSeries().props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistSeries()),
      expect: () => [
        SeriesWatchlistLoading(),
        SeriesWatchlistError('Server Failure'),
      ],
      verify: (bloc) => SeriesWatchlistLoading(),
    );
  });

  group('TV Series Watchlist Status BLoC testing', () {
    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data loaded successfully',
      build: () {
        when(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusSeries(testTvSeriesDetail.id)),
      expect: () => [InsertSeriesWatchlist(true)],
      verify: (bloc) {
        verify(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id));
        return LoadWatchlistStatusSeries(testTvSeriesDetail.id).props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockGetTvSeriesWatchListStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusSeries(testTvSeriesDetail.id)),
      expect: () => [InsertSeriesWatchlist(false)],
      verify: (bloc) => SeriesWatchlistLoading(),
    );
  });

  group('TV Series Adding watchlist BLoC testing', () {
    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data loaded successfully',
      build: () {
        when(mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistSeries(testTvSeriesDetail)),
      expect: () => [
        SeriesWatchlistLoading(),
        WatchlistSeriesMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail));
        return InsertWatchlistSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistSeries(testTvSeriesDetail)),
      expect: () => [
        SeriesWatchlistLoading(),
        SeriesWatchlistError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistSeries(testTvSeriesDetail),
    );
  });

  group('TV Series Remove watchlist BLoC testing', () {
    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data is loaded successfully',
      build: () {
        when(mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistSeriesMessage('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail));
        return DeleteWatchlistSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when fetching is unsuccessful',
      build: () {
        when(mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistSeries(testTvSeriesDetail)),
      expect: () => [
        SeriesWatchlistError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistSeries(testTvSeriesDetail),
    );
  });
}
