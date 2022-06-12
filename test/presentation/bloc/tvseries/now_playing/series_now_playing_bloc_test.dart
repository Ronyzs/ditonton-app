import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_list/series_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([SeriesNowPlayingBloc, GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late SeriesNowPlayingBloc seriesNowPlayingBloc;

  setUp(
    () {
      mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
      seriesNowPlayingBloc = SeriesNowPlayingBloc(mockGetNowPlayingTvSeries);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(seriesNowPlayingBloc.state, SeriesNowPlayingEmpty());
    },
  );

  group(
    'Now playing TV Series BLoC test',
    () {
      blocTest<SeriesNowPlayingBloc, SeriesNowPlayingState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetNowPlayingTvSeries.execute())
              .thenAnswer((_) async => Right(testTvSeriesList));
          return seriesNowPlayingBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingSeries()),
        expect: () => [
          SeriesNowPlayingLoading(),
          SeriesNowPlayingHasData(testTvSeriesList)
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvSeries.execute());
        },
      );

      blocTest<SeriesNowPlayingBloc, SeriesNowPlayingState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetNowPlayingTvSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return seriesNowPlayingBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingSeries()),
        expect: () => [
          SeriesNowPlayingLoading(),
          SeriesNowPlayingError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvSeries.execute());
        },
      );
    },
  );
}
