import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data_movie/dummy_objects.dart';
import 'movie_detail_test_mocks.dart';

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;
  late Widget widgetTest;

  setUp(() {
    registerFallbackValue(PopularMovieEventFake());
    registerFallbackValue(PopularMovieStateFake());
    mockPopularMovieBloc = MockPopularMovieBloc();
    widgetTest = PopularMoviesPage();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (e) => mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (e) => mockPopularMovieBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => FakeHomePage(),
    MOVIE_DETAIL_ROUTE: (BuildContext context) => FakeTargetPage(),
    '/second': (BuildContext context) => _makeAnotherTestableWidget(widgetTest),
  };

  group('Popular movie list', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieLoading());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should go back when onBack tapped',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularMovieHasData([]));

      await tester.pumpWidget(MaterialApp(routes: routes));
      expect(find.byKey(Key('fake_tile')), findsOneWidget);

      await tester.tap(find.byKey(Key('fake_tile')));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(seconds: 1));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
      expect(find.byKey(Key('fake_tile')), findsNothing);

      await tester.tap(find.byKey(Key('button_back')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(seconds: 1));
      expect(listViewFinder, findsNothing);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularMovieHasData([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Listview should show movie card', (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularMovieHasData([testMovie]));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      final movieCardFinder = find.byType(MovieCard);

      expect(movieCardFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularMovieError('Error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieEmpty());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      final textFinder = find.byKey(Key('Empty'));

      expect(textFinder, findsOneWidget);
    });
  });
}
