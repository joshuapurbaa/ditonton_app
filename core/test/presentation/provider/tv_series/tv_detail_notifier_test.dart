import 'package:core/core.dart';
import 'package:core/tv_series/domain/entities/tv.dart';
import 'package:core/tv_series/domain/usecase/get_detail_tv.dart';
import 'package:core/tv_series/domain/usecase/get_tv_recommendations.dart';
import 'package:core/tv_series/domain/usecase/get_watchlist_tv_status.dart';
import 'package:core/tv_series/domain/usecase/remove_watchlist_tv.dart';
import 'package:core/tv_series/domain/usecase/save_watchlist_tv.dart';
import 'package:core/tv_series/presentation/provider/detail_tv_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTVs,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetDetailTVs mockGetDetailTVs;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailTVs = MockGetDetailTVs();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
      getDetailTVs: mockGetDetailTVs,
      getTvRecommendations: mockGetTvRecommendations,
      getTvWatchListStatus: mockGetTvWatchListStatus,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  final tTvSeriesList = <Tv>[testTvSeries];

  void _arrangeUsecaseTvSeries() {
    when(mockGetDetailTVs.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecaseTvSeries();

      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetDetailTVs.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecaseTvSeries();

      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecaseTvSeries();

      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Loaded);
      expect(provider.tvDetail, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecaseTvSeries();

      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendation, tTvSeriesList);
    });

    test(
        'should change tv series recommendation when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecaseTvSeries();

      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendation, tTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetDetailTVs.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Tv Series Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvSeriesDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetDetailTVs.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
