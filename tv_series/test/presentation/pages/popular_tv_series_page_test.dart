import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_test_mocks.dart';

void main() {
  late MockPopularTvBloc mockPopularTvBloc;
  late Widget widgetTest;

  setUp(() {
    registerFallbackValue(PopularTvEventFake());
    registerFallbackValue(PopularTvStateFake());
    mockPopularTvBloc = MockPopularTvBloc();
    widgetTest = PopularTvPage();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (e) => mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (e) => mockPopularTvBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => FakeHomePage(),
    MOVIE_DETAIL_ROUTE: (BuildContext context) => FakeTargetPage(),
    '/second': (BuildContext context) => _makeAnotherTestableWidget(widgetTest),
  };

  group('Popular tv list', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should go back when onBack tapped',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvHasData([]));

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
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvHasData([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Listview should show tv card', (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state)
          .thenReturn(PopularTvHasData([testTv]));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      final tvCardFinder = find.byType(TvCard);

      expect(tvCardFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state)
          .thenReturn(PopularTvError('Error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Empty',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvEmpty());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));

      final textFinder = find.byKey(Key('Empty'));

      expect(textFinder, findsOneWidget);
    });
  });
}
