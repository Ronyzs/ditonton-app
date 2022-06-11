import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedBloc(this.getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<FetchTopRatedList>(
      (event, emit) async {
        emit(MovieTopRatedLoading());

        final result = await getTopRatedMovies.execute();
        result.fold(
          (failure) => emit(MovieTopRatedError(failure.message)),
          (data) => emit(MovieTopRatedHasData(data)),
        );
      },
    );
  }
}
