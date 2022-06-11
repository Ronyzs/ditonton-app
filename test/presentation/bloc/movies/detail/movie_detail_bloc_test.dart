import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  setUp(
    () {
      mockGetMovieDetail = MockGetMovieDetail();
      movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
    },
  );

  test(
    "initial state should be empty",
    () {
      expect(movieDetailBloc.state, MovieDetailEmpty());
    },
  );

  group(
    'Detail movies BLoC test',
    () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetMovieDetail.execute(testMovieDetail.id))
              .thenAnswer((_) async => Right(testMovieDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(testMovieDetail.id)),
        expect: () =>
            [MovieDetailLoading(), MovieDetailHasData(testMovieDetail)],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(testMovieDetail.id));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when fetch is unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(testMovieDetail.id))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(testMovieDetail.id)),
        expect: () =>
            [MovieDetailLoading(), MovieDetailError('Server Failure')],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(testMovieDetail.id));
        },
      );
    },
  );
}
