import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(MovieSearchEmpty()) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    }

    on<QueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(MovieSearchLoading());
      final result = await searchMovies.execute(query);

      result.fold(
        (failure) => emit(MovieSearchError(failure.message)),
        (data) => emit(
          MovieSearchHasData(data),
        ),
      );
    }, transformer: debounce(Duration(milliseconds: 1000)));
  }
}
