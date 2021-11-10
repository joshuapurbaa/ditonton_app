import 'package:core/core.dart';
import 'package:core/tv_series/domain/entities/tv.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/provider/search_tv_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVs])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTVs mockSearchTVs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTVs = MockSearchTVs();
    provider = TvSearchNotifier(searchTVs: mockSearchTVs)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final testTvSeries = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2016-08-28'),
    genreIds: [],
    id: 1,
    name: 'name',
    originCountry: [],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <Tv>[testTvSeries];
  final tQuery = 'game of thrones';

  group('Search Tv Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
