import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  SeriesDetailBloc(this.getTvSeriesDetail) : super(SeriesDetailEmpty()) {
    on<FetchSeriesDetail>(
      (event, emit) async {
        emit(SeriesDetailLoading());

        final result = await getTvSeriesDetail.execute(event.id);
        result.fold(
          (error) => emit(SeriesDetailError(error.message)),
          (data) => emit(SeriesDetailHasData(data)),
        );
      },
    );
  }
}
