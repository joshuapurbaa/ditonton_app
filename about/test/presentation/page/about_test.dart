import 'package:about/presentation/page/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => FakeHomePage(),
    '/second': (BuildContext context) => AboutPage(),
  };
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Description app text should display',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(
        find.text(
            'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.'),
        findsOneWidget);
  });

  testWidgets('Page should render and go back when back tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(routes: routes));
    expect(find.byKey(Key('fake_tile')), findsOneWidget);

    await tester.tap(find.byKey(Key('fake_tile')));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 1));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    expect(find.byKey(Key('fake_tile')), findsNothing);

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 1));
    expect(imageFinder, findsNothing);
  });
}
