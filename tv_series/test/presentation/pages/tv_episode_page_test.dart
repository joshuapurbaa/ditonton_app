import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/bloc/tv_episode_bloc/tv_episode_bloc.dart';
import 'package:tv_series/presentation/pages/tv_episode_page.dart';

import 'season_episode_test_mocks.dart';

void main() {
  late MockTvEpisodeBloc mockTvEpisodeBloc;
  late Widget widgetTest;

  final tId = 1;

  setUp(() {
    registerFallbackValue(TvEpisodeEventFake());
    registerFallbackValue(TvEpisodeStateFake());
    mockTvEpisodeBloc = MockTvEpisodeBloc();
    widgetTest = TvEpisodePage(id: tId, seasonNumber: tId, episodeNumber: tId);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvEpisodeBloc>(
      create: (e) => mockTvEpisodeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvEpisodeBloc.state).thenReturn(EpisodeLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(widgetTest));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvEpisodeBloc.state)
        .thenReturn(EpisodeError('Error message'));

    final textFinder = find.byKey(Key('episodes_message_error'));

    await tester.pumpWidget(_makeTestableWidget(widgetTest));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockTvEpisodeBloc.state).thenReturn(EpisodeEmpty());

    await tester.pumpWidget(_makeTestableWidget(widgetTest));

    final textFinder = find.byKey(Key('error_image'));

    expect(textFinder, findsOneWidget);
  });
}
