import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/security.dart';
import 'package:ditonton/common/utils.dart';
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
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/tvseries/home_tvseries_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tvseries_search_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/pages/tvseries/watchlist_tvseries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  di.init();
  await HttpSSLPinning.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Movies State Management
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),

        // TV Series State Management
        BlocProvider(
          create: (_) => di.locator<SeriesNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvSeriesDetailPage.ROUTE_NAME:
              final idSeries = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: idSeries),
                settings: settings,
              );
            case MovieSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => MovieSearchPage());
            case TvSeriesSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSeriesSearchPage());
            case ListWatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => ListWatchlistPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
