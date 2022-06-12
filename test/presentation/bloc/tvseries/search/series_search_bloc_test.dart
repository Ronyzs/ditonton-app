import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_search/series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late SeriesSearchBloc seriesSearchBloc;

  setUp(
    () {
      mockSearchTvSeries = MockSearchTvSeries();
      seriesSearchBloc = SeriesSearchBloc(mockSearchTvSeries);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(seriesSearchBloc.state, SeriesSearchEmpty());
    },
  );

  final tQuery = 'halo';

  blocTest<SeriesSearchBloc, SeriesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return seriesSearchBloc;
    },
    act: (bloc) => bloc.add(QuerySeriesChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SeriesSearchLoading(),
      SeriesSearchHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<SeriesSearchBloc, SeriesSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesSearchBloc;
    },
    act: (bloc) => bloc.add(QuerySeriesChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SeriesSearchLoading(),
      SeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
