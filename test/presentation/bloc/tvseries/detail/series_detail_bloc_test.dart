import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_detail/series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([SeriesDetailBloc, GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late SeriesDetailBloc seriesDetailBloc;

  setUp(
    () {
      mockGetTvSeriesDetail = MockGetTvSeriesDetail();
      seriesDetailBloc = SeriesDetailBloc(mockGetTvSeriesDetail);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(seriesDetailBloc.state, SeriesDetailEmpty());
    },
  );

  group(
    'TV Series detail BLoC test',
    () {
      blocTest<SeriesDetailBloc, SeriesDetailState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetTvSeriesDetail.execute(testTvSeriesDetail.id))
              .thenAnswer((_) async => Right(testTvSeriesDetail));
          return seriesDetailBloc;
        },
        act: (bloc) => bloc.add(FetchSeriesDetail(testMovieDetail.id)),
        expect: () =>
            [SeriesDetailLoading(), SeriesDetailHasData(testTvSeriesDetail)],
        verify: (bloc) {
          verify(mockGetTvSeriesDetail.execute(testMovieDetail.id));
        },
      );

      blocTest<SeriesDetailBloc, SeriesDetailState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetTvSeriesDetail.execute(testTvSeriesDetail.id))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return seriesDetailBloc;
        },
        act: (bloc) => bloc.add(FetchSeriesDetail(testTvSeriesDetail.id)),
        expect: () =>
            [SeriesDetailLoading(), SeriesDetailError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTvSeriesDetail.execute(testTvSeriesDetail.id));
        },
      );
    },
  );
}
