import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_page_helper.dart';

void main() {
  late FakeMovieDetailBloc fakeMovieDetailBloc;
  late FakeMovieRecommendationBloc fakeMovieRecommendationBloc;
  late FakeMovieWatchlistBloc fakeMovieWatchlistBloc;

  setUp(
    () {
      registerFallbackValue(FakeMovieDetailEvent());
      registerFallbackValue(FakeMovieDetailState());
      fakeMovieDetailBloc = FakeMovieDetailBloc();

      registerFallbackValue(FakeMovieRecommendationEvent());
      registerFallbackValue(FakeMovieRecommendationState());
      fakeMovieRecommendationBloc = FakeMovieRecommendationBloc();

      registerFallbackValue(FakeMovieWatchlistEvent());
      registerFallbackValue(FakeMovieWatchlistState());
      fakeMovieWatchlistBloc = FakeMovieWatchlistBloc();
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => fakeMovieDetailBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (_) => fakeMovieWatchlistBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => fakeMovieRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display progress bar when loading',
    (WidgetTester tester) async {
      when(() => fakeMovieDetailBloc.state).thenReturn(MovieDetailLoading());
      when(() => fakeMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoading());
      when(() => fakeMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistLoading());

      final watchlistButtonIcon = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display List view when loaded',
    (WidgetTester tester) async {
      when(() => fakeMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => fakeMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationHasData(testMovieList));
      when(() => fakeMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error message when Error',
    (WidgetTester tester) async {
      final tMsg = 'Server Failure';

      when(() => fakeMovieDetailBloc.state).thenReturn(MovieDetailError(tMsg));
      when(() => fakeMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationError(tMsg));
      when(() => fakeMovieWatchlistBloc.state)
          .thenReturn(MovieWatchlistError(tMsg));

      final textFinder = find.text('Server Failure');

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    },
  );
}
