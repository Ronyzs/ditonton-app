import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_watchlist_event.dart';
part 'series_watchlist_state.dart';

class SeriesWatchlistBloc
    extends Bloc<SeriesWatchlistEvent, SeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;

  SeriesWatchlistBloc(
    this.getWatchlistTvSeries,
    this.getTvSeriesWatchListStatus,
    this.saveTvSeriesWatchlist,
    this.removeTvSeriesWatchlist,
  ) : super(SeriesWatchlistEmpty()) {
    on<FetchWatchlistSeries>(
      (event, emit) async {
        emit(SeriesWatchlistLoading());

        final result = await getWatchlistTvSeries.execute();
        result.fold(
          (failure) => emit(SeriesWatchlistError(failure.message)),
          (data) => emit(
            SeriesWatchlistHasData(data),
          ),
        );
      },
    );

    on<InsertWatchlistSeries>(
      (event, emit) async {
        emit(SeriesWatchlistLoading());
        final series = event.series;

        final result = await saveTvSeriesWatchlist.execute(series);

        result.fold(
          (failure) => emit(SeriesWatchlistError(failure.message)),
          (msg) => emit(WatchlistSeriesMessage(msg)),
        );
      },
    );

    on<DeleteWatchlistSeries>(
      (event, emit) async {
        final series = event.series;

        final result = await removeTvSeriesWatchlist.execute(series);

        result.fold(
          (failure) => emit(SeriesWatchlistError(failure.message)),
          (msg) => emit(WatchlistSeriesMessage(msg)),
        );
      },
    );

    on<LoadWatchlistStatusSeries>(
      (event, emit) async {
        final id = event.id;

        final result = await getTvSeriesWatchListStatus.execute(id);

        emit(InsertSeriesWatchlist(result));
      },
    );
  }
}
