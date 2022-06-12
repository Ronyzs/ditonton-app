import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_popular/series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_popular_bloc_test.mocks.dart';

@GenerateMocks([SeriesPopularBloc, GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late SeriesPopularBloc seriesPopularBloc;

  setUp(
    () {
      mockGetPopularTv = MockGetPopularTv();
      seriesPopularBloc = SeriesPopularBloc(mockGetPopularTv);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(seriesPopularBloc.state, SeriesPopularEmpty());
    },
  );

  group(
    'Popular TV Series BLoC test',
    () {
      blocTest<SeriesPopularBloc, SeriesPopularState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(testTvSeriesList));
          return seriesPopularBloc;
        },
        act: (bloc) => bloc.add(FetchPopularSeriesList()),
        expect: () =>
            [SeriesPopularLoading(), SeriesPopularHasData(testTvSeriesList)],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        },
      );

      blocTest<SeriesPopularBloc, SeriesPopularState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return seriesPopularBloc;
        },
        act: (bloc) => bloc.add(FetchPopularSeriesList()),
        expect: () =>
            [SeriesPopularLoading(), SeriesPopularError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        },
      );
    },
  );
}
