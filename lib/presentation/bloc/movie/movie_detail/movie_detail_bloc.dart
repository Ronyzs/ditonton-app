import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        emit(MovieDetailLoading());

        final result = await getMovieDetail.execute(event.id);
        result.fold(
          (error) => emit(MovieDetailError(error.message)),
          (data) => emit(MovieDetailHasData(data)),
        );
      },
    );
  }
}
