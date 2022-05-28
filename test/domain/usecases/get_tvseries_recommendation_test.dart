import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepo;

  setUp(() {
    mockTvSeriesRepo = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepo);
  });

  final tId = 1;
  final tSeries = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockTvSeriesRepo.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSeries));
  });
}
