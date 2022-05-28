import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTvSeriesWatchlist removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getTvSeriesWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvSeriesDetail _detail;
  TvSeriesDetail get detail => _detail;

  RequestState _detailState = RequestState.Empty;
  RequestState get detailState => _detailState;

  List<TvSeries> _seriesRecommendations = [];
  List<TvSeries> get seriesRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _detailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _detailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (detail) {
        _recommendationState = RequestState.Loading;
        _detail = detail;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (series) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = series;
          },
        );
        _detailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addTvSeriesWatchlist(TvSeriesDetail series) async {
    final result = await saveWatchlist.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadTvSeriesWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail detail) async {
    final result = await removeWatchlist.execute(detail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadTvSeriesWatchlistStatus(detail.id);
  }

  Future<void> loadTvSeriesWatchlistStatus(int id) async {
    final result = await getTvSeriesWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    print(result);
    notifyListeners();
  }
}
