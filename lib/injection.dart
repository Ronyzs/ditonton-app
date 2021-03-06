import 'package:ditonton/common/security.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_respository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_detail/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_list/series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_popular/series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_recommendation/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_search/series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_top_rated/series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_watchlist/series_watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Movies BLoC
  locator.registerFactory(() => MovieNowPlayingBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieTopRatedBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // TV Series BLoC
  locator.registerFactory(() => SeriesNowPlayingBloc(locator()));
  locator.registerFactory(() => SeriesDetailBloc(locator()));
  locator.registerFactory(() => SeriesPopularBloc(locator()));
  locator.registerFactory(() => SeriesTopRatedBloc(locator()));
  locator.registerFactory(() => SeriesRecommendationBloc(locator()));
  locator.registerFactory(() => SeriesSearchBloc(locator()));
  locator.registerFactory(
    () => SeriesWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
