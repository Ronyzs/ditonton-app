import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'series_top_rated_event.dart';
part 'series_top_rated_state.dart';

class SeriesTopRatedBloc
    extends Bloc<SeriesTopRatedEvent, SeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  SeriesTopRatedBloc(this.getTopRatedTvSeries) : super(SeriesTopRatedEmpty()) {
    on<FetchTopRatedSeriesList>(
      (event, emit) async {
        emit(SeriesTopRatedLoading());

        final result = await getTopRatedTvSeries.execute();
        result.fold(
          (failure) => emit(SeriesTopRatedError(failure.message)),
          (data) => emit(SeriesTopRatedHasData(data)),
        );
      },
    );
  }
}
