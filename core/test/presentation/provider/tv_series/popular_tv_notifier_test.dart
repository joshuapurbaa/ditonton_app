import 'package:core/core.dart';
import 'package:core/tv_series/domain/entities/tv.dart';
import 'package:core/tv_series/domain/usecase/get_popular_tv.dart';
import 'package:core/tv_series/presentation/provider/popular_tv_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVs])
void main() {
  late MockGetPopularTVs mockGetPopularTVs;
  late PopularTvNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVs = MockGetPopularTVs();
    provider = PopularTvNotifier(getPopularTVs: mockGetPopularTVs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: DateTime.parse('2016-08-28'),
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );

  final tTvSeriesList = <Tv>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVs.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    provider.fetchPopularTvSeries();
    // assert
    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetPopularTVs.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await provider.fetchPopularTvSeries();
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeries, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTVs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchPopularTvSeries();
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
