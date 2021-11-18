import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_watchlist_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetDetailTVs,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late TvRecommendationsBloc tvRecommendationsBloc;
  late TvDetailWatchlistBloc tvWatchlistBloc;
  late MockGetDetailTVs mockGetDetailTVs;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetDetailTVs = MockGetDetailTVs();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(mockGetDetailTVs);
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
    tvWatchlistBloc = TvDetailWatchlistBloc(
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
      mockGetTvWatchListStatus,
    );
  });

  final tId = 1;

  final tTVs = <Tv>[testTv];

  group('Get Tv Detail', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvDetailEmpty());
      expect(FetchTvDetail(tId).props, [tId]);
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetDetailTVs.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (detail) => detail.add(FetchTvDetail(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailHasData(testTvDetail),
      ],
      verify: (detail) {
        verify(mockGetDetailTVs.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetDetailTVs.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (detail) => detail.add(FetchTvDetail(tId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError('Server Failure'),
      ],
      verify: (detail) {
        verify(mockGetDetailTVs.execute(tId));
      },
    );
  });

  group('Get Tv Recommendations', () {
    test('initial state should be empty', () {
      expect(tvRecommendationsBloc.state, TvRecommendationEmpty());
      expect(FetchTvRecommendations(tId).props, [tId]);
    });

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTVs));
        return tvRecommendationsBloc;
      },
      act: (detail) => detail.add(FetchTvRecommendations(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationHasData(tTVs),
      ],
      verify: (detail) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvRecommendationsBloc;
      },
      act: (detail) => detail.add(FetchTvRecommendations(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationError('Server Failure'),
      ],
      verify: (detail) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    test('initial state should be empty', () {
      expect(tvWatchlistBloc.state, ReceivedStatus(false, ''));
      expect(AddWatchlist(testTvDetail).props, [testTvDetail]);
      expect(RemoveFromWatchlist(testTvDetail).props, [testTvDetail]);
      expect(LoadTvWatchlistStatus(tId).props, [tId]);
    });

    blocTest<TvDetailWatchlistBloc, TvWatchlistState>(
      'Should emit [Received] when data is saved successfully',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async =>
            Right(TvDetailWatchlistBloc.watchlistAddSuccessMessage));
        return tvWatchlistBloc;
      },
      act: (detail) => detail.add(AddWatchlist(testTvDetail)),
      expect: () => [
        LoadingStatus(),
        ReceivedStatus(true, TvDetailWatchlistBloc.watchlistAddSuccessMessage),
      ],
      verify: (detail) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<TvDetailWatchlistBloc, TvWatchlistState>(
      'Should emit [Error] when save data is unsuccessful',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return tvWatchlistBloc;
      },
      act: (detail) => detail.add(AddWatchlist(testTvDetail)),
      expect: () => [
        LoadingStatus(),
        ErrorStatus('Database Failure'),
      ],
      verify: (detail) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<TvDetailWatchlistBloc, TvWatchlistState>(
      'Should emit [Received] when data is removed successfully',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async =>
                Right(TvDetailWatchlistBloc.watchlistRemoveSuccessMessage));
        return tvWatchlistBloc;
      },
      act: (detail) => detail.add(RemoveFromWatchlist(testTvDetail)),
      expect: () => [
        LoadingStatus(),
        ReceivedStatus(
            false, TvDetailWatchlistBloc.watchlistRemoveSuccessMessage),
      ],
      verify: (detail) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<TvDetailWatchlistBloc, TvWatchlistState>(
      'Should emit [Error] when remove data is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return tvWatchlistBloc;
      },
      act: (detail) => detail.add(RemoveFromWatchlist(testTvDetail)),
      expect: () => [
        LoadingStatus(),
        ErrorStatus('Database Failure'),
      ],
      verify: (detail) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );
    blocTest<TvDetailWatchlistBloc, TvWatchlistState>(
      'Should emit [Received] when get status',
      build: () {
        when(mockGetTvWatchListStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvWatchlistBloc;
      },
      act: (detail) => detail.add(LoadTvWatchlistStatus(tId)),
      expect: () => [
        ReceivedStatus(true, ''),
      ],
      verify: (detail) {
        verify(mockGetTvWatchListStatus.execute(tId));
      },
    );
  });
}
