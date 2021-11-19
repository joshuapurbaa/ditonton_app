import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';

import 'search_page_test_mocks.dart';

void main() {
  late MockMovieSearchBloc mockMovieSearchBloc;
  late MockTvSearchBloc mockTvSearchBloc;
  late Widget widgetTest;

  setUpAll(() {
    registerFallbackValue(MovieSearchStateFake());
    registerFallbackValue(MovieSearchEventFake());
    registerFallbackValue(TvSearchStateFake());
    registerFallbackValue(TvSearchEventFake());

    mockMovieSearchBloc = MockMovieSearchBloc();
    mockTvSearchBloc = MockTvSearchBloc();
    widgetTest = SearchPage();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(create: (e) => mockMovieSearchBloc),
        BlocProvider<SearchTvBloc>(create: (e) => mockTvSearchBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Search page', () {
    testWidgets('should display textfield', (WidgetTester tester) async {
      when(() => mockMovieSearchBloc.state).thenReturn(SearchMovieLoading());
      when(() => mockTvSearchBloc.state).thenReturn(SearchTvLoading());

      await tester.pumpWidget(_makeTestableWidget(widgetTest));
      final textfieldFinder = find.byType(TextField);
      expect(textfieldFinder, findsOneWidget);
    });
  });
}
