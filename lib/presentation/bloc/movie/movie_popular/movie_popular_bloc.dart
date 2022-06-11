import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularBloc(this.getPopularMovies) : super(MoviePopularEmpty()) {
    on<FetchPopularList>(
      (event, emit) async {
        emit(MoviePopularLoading());

        final result = await getPopularMovies.execute();
        result.fold(
          (failure) => emit(MoviePopularError(failure.message)),
          (data) => emit(MoviePopularHasData(data)),
        );
      },
    );
  }
}
