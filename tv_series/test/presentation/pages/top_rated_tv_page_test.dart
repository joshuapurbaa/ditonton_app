import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_test_mocks.dart';

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;
  late Widget widgetTest;

  setUp(() {
    registerFallbackValue(TopRatedTvEventFake());
    registerFallbackValue(TopRatedTvStateFake());
    mockTopRatedTvBloc = MockTopRatedTvBloc();
    widgetTest = TopRatedTvPage();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (e) => mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (e) => mockTopRatedTvBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => FakeHomePage(),
    MOVIE_DETAIL_ROUTE: (BuildContext context) => FakeTargetPage(),
    '/second': (BuildContext context) => _makeAnotherTestableWidget(
          widgetTest,
        ),
  };

  group('Top rated tv list', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should go back when onBack tapped',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvHasData([]));

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
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvHasData([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Listview should show tv card', (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TopRatedTvHasData([testTv]));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      final tvCardFinder = find.byType(TvCard);

      expect(tvCardFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TopRatedTvError('Error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvEmpty());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      final textFinder = find.byKey(Key('Empty'));

      expect(textFinder, findsOneWidget);
    });
  });
}
