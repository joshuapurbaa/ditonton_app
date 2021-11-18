import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_watchlist_bloc.dart';
import 'package:tv_series/presentation/pages/detail_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_test_mocks.dart';

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvWatchlistDetailBloc mockTvDetailWatchlistBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late Widget widgetTest;

  final tId = 1;

  setUpAll(() {
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvWatchlistDetailStateFake());
    registerFallbackValue(TvWatchlistDetailEventFake());
    registerFallbackValue(TvRecommendationsStateFake());
    registerFallbackValue(TvRecommendationsEventFake());

    mockTvDetailBloc = MockTvDetailBloc();
    mockTvDetailWatchlistBloc = MockTvWatchlistDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    widgetTest = DetailTvPage(id: tId);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: BlocProvider<TvDetailWatchlistBloc>.value(
        value: mockTvDetailWatchlistBloc,
        child: BlocProvider<TvRecommendationsBloc>.value(
          value: mockTvRecommendationsBloc,
          child: MaterialApp(
            home: body,
          ),
        ),
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: BlocProvider<TvDetailWatchlistBloc>.value(
        value: mockTvDetailWatchlistBloc,
        child: BlocProvider<TvRecommendationsBloc>.value(
          value: mockTvRecommendationsBloc,
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
        'should display CircularProgressIndicator when state is TvDetailLoading',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoading());
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationEmpty());
      when(() => mockTvDetailWatchlistBloc.state)
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
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationHasData([]));
      when(() => mockTvDetailWatchlistBloc.state)
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
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationHasData([]));
      when(() => mockTvDetailWatchlistBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationHasData([]));
      whenListen(
        mockTvDetailWatchlistBloc,
        Stream.fromIterable([
          ReceivedStatus(false, ''),
          LoadingStatus(),
          ReceivedStatus(
            true,
            TvDetailWatchlistBloc.watchlistAddSuccessMessage,
          ),
        ]),
        initialState: ReceivedStatus(false, ''),
      );

      expect(mockTvDetailWatchlistBloc.state, ReceivedStatus(false, ''));

      final watchlistButton = find.byKey(Key('btn_watchlist'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);

      await tester.pump();
      verify(
        () => mockTvDetailWatchlistBloc.add(
          AddWatchlist(testTvDetail),
        ),
      ).called(1);
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(
        mockTvDetailWatchlistBloc.state,
        ReceivedStatus(true, TvDetailWatchlistBloc.watchlistAddSuccessMessage),
      );
      expect(find.text(TvDetailWatchlistBloc.watchlistAddSuccessMessage),
          findsOneWidget);
    });
    testWidgets(
        'Watchlist button should display AlertDialog when watchlist status is Error',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationHasData([]));
      whenListen(
        mockTvDetailWatchlistBloc,
        Stream.fromIterable([
          ReceivedStatus(false, ''),
          LoadingStatus(),
          ErrorStatus('Database Failure')
        ]),
        initialState: ReceivedStatus(false, ''),
      );

      expect(mockTvDetailWatchlistBloc.state, ReceivedStatus(false, ''));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.byIcon(Icons.check), findsNothing);
      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(mockTvDetailWatchlistBloc.state, ErrorStatus('Database Failure'));
    });

    testWidgets(
        'Recommendation should display loading first when its come to load',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationLoading());
      when(() => mockTvDetailWatchlistBloc.state)
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
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationHasData([testTv]));
      when(() => mockTvDetailWatchlistBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Recommendations should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationError('Error message'));
      when(() => mockTvDetailWatchlistBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final textFinder = find.byKey(Key('recom_error_message'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailError('Error message'));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationEmpty());
      when(() => mockTvDetailWatchlistBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final textFinder = find.byKey(
        Key('error_message'),
      );

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailEmpty());
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvRecommendationEmpty());
      when(() => mockTvDetailWatchlistBloc.state)
          .thenReturn(ReceivedStatus(false, ''));

      final textFinder = find.text('Empty');

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });
  });
}
