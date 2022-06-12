import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_top_rated/series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries, SeriesTopRatedBloc])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late SeriesTopRatedBloc seriesTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    seriesTopRatedBloc = SeriesTopRatedBloc(mockGetTopRatedTvSeries);
  });

  test("initial state should be empty", () {
    expect(seriesTopRatedBloc.state, SeriesTopRatedEmpty());
  });

  group(
    'Top rated TV Series BLoC test',
    () {
      blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetTopRatedTvSeries.execute())
              .thenAnswer((_) async => Right(testTvSeriesList));
          return seriesTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedSeriesList()),
        expect: () =>
            [SeriesTopRatedLoading(), SeriesTopRatedHasData(testTvSeriesList)],
        verify: (bloc) {
          verify(mockGetTopRatedTvSeries.execute());
        },
      );

      blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetTopRatedTvSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return seriesTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedSeriesList()),
        expect: () =>
            [SeriesTopRatedLoading(), SeriesTopRatedError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedTvSeries.execute());
        },
      );
    },
  );
}
