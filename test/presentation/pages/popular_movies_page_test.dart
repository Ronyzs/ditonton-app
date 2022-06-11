import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_page_helper.dart';

void main() {
  late FakePopularMovieBloc fakePopularMovieBloc;

  setUp(
    () {
      registerFallbackValue(FakePopularMovieEvent());
      registerFallbackValue(FakePopularMovieState());
      fakePopularMovieBloc = FakePopularMovieBloc();
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviePopularBloc>(
          create: (_) => fakePopularMovieBloc,
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
      when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularLoading());

      final watchlistButtonIcon = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display List view when loaded',
    (WidgetTester tester) async {
      when(() => fakePopularMovieBloc.state)
          .thenReturn(MoviePopularHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error message when Error',
    (WidgetTester tester) async {
      final tMsg = 'Server Failure';

      when(() => fakePopularMovieBloc.state)
          .thenReturn(MoviePopularError(tMsg));

      final textFinder = find.text('Server Failure');

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
