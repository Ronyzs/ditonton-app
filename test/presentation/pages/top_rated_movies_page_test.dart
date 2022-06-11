import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_page_helper.dart';

void main() {
  late FakeTopRatedBloc fakeTopRatedBloc;

  setUp(
    () {
      registerFallbackValue(FakeTopRatedEvent());
      registerFallbackValue(FakeTopRatedState());
      fakeTopRatedBloc = FakeTopRatedBloc();
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieTopRatedBloc>(
          create: (_) => fakeTopRatedBloc,
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
      when(() => fakeTopRatedBloc.state).thenReturn(MovieTopRatedLoading());

      final watchlistButtonIcon = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display List view when loaded',
    (WidgetTester tester) async {
      when(() => fakeTopRatedBloc.state)
          .thenReturn(MovieTopRatedHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error message when Error',
    (WidgetTester tester) async {
      final tMsg = 'Server Failure';

      when(() => fakeTopRatedBloc.state).thenReturn(MovieTopRatedError(tMsg));

      final textFinder = find.text('Server Failure');

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
