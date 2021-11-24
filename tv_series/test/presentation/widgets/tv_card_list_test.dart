import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

void main() {
  late Tv tv;

  setUp(() {
    tv = Tv(
      posterPath: '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
      popularity: 11.520271,
      id: 67419,
      backdropPath: '/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg',
      voteAverage: 1.39,
      overview:
          'The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.',
      firstAirDate: '2016-08-28',
      originCountry: ['GB'],
      genreIds: [18],
      originalLanguage: 'en',
      voteCount: 9,
      name: 'Victoria',
      originalName: 'Victoria',
    );
  });

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
    final cardFinder = find.byType(Card);
    await tester.pumpWidget(_makeTestableWidget(TvCard(
      tv,
    )));
    final textFinder = find.text('Victoria');
    expect(textFinder, findsOneWidget);
    expect(cardFinder, findsOneWidget);
  });
}
