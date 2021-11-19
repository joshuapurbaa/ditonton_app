import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_watchlist_detail_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_test_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistDetailBloc mockMovieWatchlistDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late Widget widgetTest;

  final tId = 1;

  setUpAll(() {
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieWatchlistDetailStateFake());
    registerFallbackValue(MovieWatchlistDetailEventFake());
    registerFallbackValue(MovieRecommendationsStateFake());
    registerFallbackValue(MovieRecommendationsEventFake());

    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieWatchlistDetailBloc = MockMovieWatchlistDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    widgetTest = MovieDetailPage(id: tId);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: BlocProvider<MovieWatchlistDetailBloc>.value(
        value: mockMovieWatchlistDetailBloc,
        child: BlocProvider<MovieRecommendationsBloc>.value(
          value: mockMovieRecommendationsBloc,
          child: MaterialApp(
            home: body,
          ),
        ),
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: BlocProvider<MovieWatchlistDetailBloc>.value(
        value: mockMovieWatchlistDetailBloc,
        child: BlocProvider<MovieRecommendationsBloc>.value(
          value: mockMovieRecommendationsBloc,
          child: body,
        ),
      ),
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => FakeHomePage(),
    MOVIE_DETAIL_ROUTE: (BuildContext context) => FakeTargetPage(),
    '/second': (BuildContext contex) => _makeAnotherTestableWidget(widgetTest),
  };

  group('Detail movie page', () {
    testWidgets(
        'should display CircularProgressIndicator when state is MovieDetailLoading',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationEmpty());
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));
      final centerFinder = find.byType(Center);
      final circularProgressIndicatorFInder =
          find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      expect(centerFinder, findsOneWidget);
      expect(circularProgressIndicatorFInder, findsOneWidget);
    });

    testWidgets('Page should go back when onBack tapped',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationHasData([]));
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      await tester.pumpWidget(MaterialApp(routes: routes));
      expect(find.byKey(Key('fake_tile')), findsOneWidget);

      await tester.tap(find.byKey(Key('fake_tile')));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(seconds: 1));

      final dssFinder = find.byType(DraggableScrollableSheet);
      expect(dssFinder, findsOneWidget);
      expect(find.byKey(Key('fake_tile')), findsNothing);

      await tester.tap(find.byKey(Key('button_back')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(seconds: 1));
      expect(dssFinder, findsNothing);
    });

    testWidgets(
        'watchlist button should display add icon when movie not added  ',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationHasData([]));
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationHasData([]));
      whenListen(
        mockMovieWatchlistDetailBloc,
        Stream.fromIterable([
          ReceivedStatus(false, ''),
          LoadingStatus(),
          ReceivedStatus(
            true,
            MovieWatchlistDetailBloc.watchlistAddSuccessMessage,
          ),
        ]),
        initialState: ReceivedStatus(false, ''),
      );

      expect(mockMovieWatchlistDetailBloc.state, ReceivedStatus(false, ''));

      final watchlistButton = find.byKey(Key('btn_watchlist'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);

      await tester.pump();
      verify(
        () => mockMovieWatchlistDetailBloc.add(
          AddWatchlist(testMovieDetail),
        ),
      ).called(1);
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(
        mockMovieWatchlistDetailBloc.state,
        ReceivedStatus(
            true, MovieWatchlistDetailBloc.watchlistAddSuccessMessage),
      );
      expect(find.text(MovieWatchlistDetailBloc.watchlistAddSuccessMessage),
          findsOneWidget);
    });
    testWidgets(
        'Watchlist button should display AlertDialog when watchlist status is Error',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationHasData([]));
      whenListen(
        mockMovieWatchlistDetailBloc,
        Stream.fromIterable([
          ReceivedStatus(false, ''),
          LoadingStatus(),
          ErrorStatus('Database Failure')
        ]),
        initialState: ReceivedStatus(false, ''),
      );

      expect(mockMovieWatchlistDetailBloc.state, ReceivedStatus(false, ''));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.byIcon(Icons.check), findsNothing);
      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
          mockMovieWatchlistDetailBloc.state, ErrorStatus('Database Failure'));
    });

    testWidgets(
        'Recommendation should display loading first when its come to load',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationLoading());
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final centerFinder = find.byKey(Key('recommendation_center'));
      final circularProgressIndicatorFInder =
          find.byKey(Key('recommendation_loading'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(centerFinder, findsOneWidget);
      expect(circularProgressIndicatorFInder, findsOneWidget);
    });

    testWidgets('Recommendation shows when exists',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationHasData([testMovie]));
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Recommendations should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationError('Error message'));
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final textFinder = find.byKey(Key('recom_error_message'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailError('Error message'));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationEmpty());
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final textFinder = find.byKey(
        Key('error_message'),
      );

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailEmpty());
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(MovieRecommendationEmpty());
      when(() => mockMovieWatchlistDetailBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final textFinder = find.text('Empty');

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });
  });
}
