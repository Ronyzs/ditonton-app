import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingBloc(this.getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<FetchNowPlayingMovies>(
      (event, emit) async {
        emit(MovieNowPlayingLoading());

        final result = await getNowPlayingMovies.execute();
        result.fold(
          (error) => emit(MovieNowPlayingError(error.message)),
          (data) => emit(MovieNowPlayingHasData(data)),
        );
      },
    );
  }
}
