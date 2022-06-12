import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'series_now_playing_event.dart';
part 'series_now_playing_state.dart';

class SeriesNowPlayingBloc
    extends Bloc<SeriesNowPlayingEvent, SeriesNowPlayingState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  SeriesNowPlayingBloc(this.getNowPlayingTvSeries)
      : super(SeriesNowPlayingEmpty()) {
    on<FetchNowPlayingSeries>(
      (event, emit) async {
        emit(SeriesNowPlayingLoading());

        final result = await getNowPlayingTvSeries.execute();
        result.fold(
          (error) => emit(SeriesNowPlayingError(error.message)),
          (data) => emit(SeriesNowPlayingHasData(data)),
        );
      },
    );
  }
}
