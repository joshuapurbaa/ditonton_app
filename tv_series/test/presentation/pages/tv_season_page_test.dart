import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:tv_series/presentation/pages/tv_season_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'season_episode_test_mocks.dart';

void main() {
  late MockTvSeasonBloc mockTvSeasonBloc;
  late Widget widgetTest;

  final tId = 1;

  setUp(() {
    registerFallbackValue(TvSeasonEventFake());
    registerFallbackValue(TvSeasonStateFake());
    mockTvSeasonBloc = MockTvSeasonBloc();
    widgetTest = TvSeasonPage(id: tId, seasonNumber: tId);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeasonBloc>(
      create: (e) => mockTvSeasonBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return BlocProvider<TvSeasonBloc>(
      create: (c) => mockTvSeasonBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => FakeHomePage(),
    TV_EPISODE_ROUTE: (BuildContext context) => FakeTargetPage(),
    '/second': (BuildContext context) => _makeAnotherTestableWidget(widgetTest),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeasonBloc.state).thenReturn(SeasonLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(widgetTest));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should go back when onBack tapped',
      (WidgetTester tester) async {
    when(() => mockTvSeasonBloc.state)
        .thenReturn(SeasonHasData(testTvSeasonWithImage));

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

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSeasonBloc.state).thenReturn(SeasonError('Error message'));

    final textFinder = find.byKey(Key('season_message_error'));

    await tester.pumpWidget(_makeTestableWidget(widgetTest));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockTvSeasonBloc.state).thenReturn(SeasonEmpty());

    await tester.pumpWidget(_makeTestableWidget(widgetTest));

    final textFinder = find.byKey(Key('error_image'));

    expect(textFinder, findsOneWidget);
  });
}
