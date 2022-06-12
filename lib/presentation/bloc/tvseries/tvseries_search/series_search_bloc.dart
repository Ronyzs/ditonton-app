import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'series_search_event.dart';
part 'series_search_state.dart';

class SeriesSearchBloc extends Bloc<SeriesSearchEvent, SeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  SeriesSearchBloc(this.searchTvSeries) : super(SeriesSearchEmpty()) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    }

    on<QuerySeriesChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(SeriesSearchLoading());
      final result = await searchTvSeries.execute(query);

      result.fold(
        (failure) => emit(SeriesSearchError(failure.message)),
        (data) => emit(
          SeriesSearchHasData(data),
        ),
      );
    }, transformer: debounce(Duration(milliseconds: 1000)));
  }
}
