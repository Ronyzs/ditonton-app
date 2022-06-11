import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistBloc(
    this.getWatchlistMovies,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieWatchlistEmpty()) {
    on<FetchWatchlistMovie>(
      (event, emit) async {
        emit(MovieWatchlistLoading());

        final result = await getWatchlistMovies.execute();
        result.fold(
          (failure) => emit(MovieWatchlistError(failure.message)),
          (data) => emit(
            MovieWatchlistHasData(data),
          ),
        );
      },
    );

    on<InsertWatchlistMovie>(
      (event, emit) async {
        emit(MovieWatchlistLoading());
        final movie = event.movie;

        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) => emit(MovieWatchlistError(failure.message)),
          (msg) => emit(WatchlistMessage(msg)),
        );
      },
    );

    on<DeleteWatchlistMovie>(
      (event, emit) async {
        final movie = event.movie;

        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) => emit(MovieWatchlistError(failure.message)),
          (msg) => emit(WatchlistMessage(msg)),
        );
      },
    );

    on<LoadWatchlistStatusMovie>(
      (event, emit) async {
        final id = event.id;

        final result = await getWatchListStatus.execute(id);

        emit(InsertWatchlist(result));
      },
    );
  }
}
