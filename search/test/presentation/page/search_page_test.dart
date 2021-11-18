import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tv_series/domain/entities/tv.dart';

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
    return BlocProvider<SearchMovieBloc>.value(
      value: mockMovieSearchBloc,
      child: BlocProvider<SearchTvBloc>.value(
        value: mockTvSearchBloc,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = [tMovie];

  final tTv = Tv(
    posterPath: '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
    popularity: 11.520271,
    id: 67419,
    backdropPath: '/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg',
    voteAverage: 1.39,
    overview:
        'The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.',
    firstAirDate: DateTime.parse('2016-08-28'),
    originCountry: ['GB'],
    genreIds: [18],
    originalLanguage: 'en',
    voteCount: 9,
    name: 'Victoria',
    originalName: 'Victoria',
  );

  final tTvList = [tTv];

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
