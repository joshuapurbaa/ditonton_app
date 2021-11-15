import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVs])
void main() {
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late TopRatedTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    notifier = TopRatedTvNotifier(getTopRatedTVs: mockGetTopRatedTVs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = Tv(
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

  final tTvSeriesList = <Tv>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVs.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    notifier.fetchTopRatedTVs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTVs.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchTopRatedTVs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvTopRated, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTVs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
