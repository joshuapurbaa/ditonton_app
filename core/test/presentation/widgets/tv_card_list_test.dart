import 'package:core/tv_series/domain/entities/tv.dart';
import 'package:core/tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:core/tv_series/presentation/provider/top_rated_tv_notifier.dart';
import 'package:core/tv_series/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_card_list_test.mocks.dart';

@GenerateMocks([TopRatedTvNotifier])
void main() {
  late MockTopRatedTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display tv series card within list view when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvTopRated).thenReturn(<Tv>[testTvSeries]);

    final tvSeriesCardFinder = find.byType(TvCard);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(tvSeriesCardFinder, findsOneWidget);
  });
}
