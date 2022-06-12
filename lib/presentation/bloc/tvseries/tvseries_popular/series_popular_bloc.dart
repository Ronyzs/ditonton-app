import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'series_popular_event.dart';
part 'series_popular_state.dart';

class SeriesPopularBloc extends Bloc<SeriesPopularEvent, SeriesPopularState> {
  final GetPopularTv getPopularTv;

  SeriesPopularBloc(this.getPopularTv) : super(SeriesPopularEmpty()) {
    on<FetchPopularSeriesList>(
      (event, emit) async {
        emit(SeriesPopularLoading());

        final result = await getPopularTv.execute();
        result.fold(
          (failure) => emit(SeriesPopularError(failure.message)),
          (data) => emit(SeriesPopularHasData(data)),
        );
      },
    );
  }
}
