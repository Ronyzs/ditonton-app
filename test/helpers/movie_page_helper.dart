import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:mockito/mockito.dart';

// Now Playing
class FakeNowPlayingMovieBloc
    extends MockBloc<MovieNowPlayingEvent, MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class FakeNowPlayingMovieEvent extends Fake implements MovieNowPlayingEvent {}

class FakeNowPlayingMovieState extends Fake implements MovieNowPlayingState {}

// Popular
class FakePopularMovieBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class FakePopularMovieEvent extends Fake implements MoviePopularEvent {}

class FakePopularMovieState extends Fake implements MoviePopularState {}

// Top Rated
class FakeTopRatedBloc extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class FakeTopRatedEvent extends Fake implements MovieTopRatedEvent {}

class FakeTopRatedState extends Fake implements MovieTopRatedState {}

// Movie Detail
class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

// Watchlist
class FakeMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class FakeMovieWatchlistEvent extends Fake implements MovieWatchlistEvent {}

class FakeMovieWatchlistState extends Fake implements MovieWatchlistState {}

// Recommendation
class FakeMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class FakeMovieRecommendationEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeMovieRecommendationState extends Fake
    implements MovieRecommendationState {}
