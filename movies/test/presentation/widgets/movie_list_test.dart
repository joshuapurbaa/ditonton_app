import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/widgets/movie_list.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      home: Scaffold(body: body),
    );
  }

  testWidgets('Check if tv card should show properly',
      (WidgetTester tester) async {
    final listviewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(MovieList(
      [testMovie],
    )));
    expect(listviewFinder, findsOneWidget);
  });
}
