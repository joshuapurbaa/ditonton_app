import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_watchlist_detail_bloc.dart';

import '../../dummy_data_movie/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MovieWatchlistDetailBloc movieWatchlistDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
    movieWatchlistDetailBloc = MovieWatchlistDetailBloc(
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group('Get Movie Detail', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state, MovieDetailEmpty());
      expect(FetchMovieDetail(tId).props, [tId]);
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (detail) => detail.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (detail) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (detail) => detail.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('Server Failure'),
      ],
      verify: (detail) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });
  group('Get Movie Recommendations', () {
    test('initial state should be empty', () {
      expect(movieRecommendationsBloc.state, MovieRecommendationEmpty());
      expect(FetchMovieRecommendations(tId).props, [tId]);
    });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieRecommendationsBloc;
      },
      act: (detail) => detail.add(FetchMovieRecommendations(tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationHasData(tMovies),
      ],
      verify: (detail) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationsBloc;
      },
      act: (detail) => detail.add(FetchMovieRecommendations(tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationError('Server Failure'),
      ],
      verify: (detail) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    test('initial state should be empty', () {
      expect(movieWatchlistDetailBloc.state, ReceivedStatus(false, ''));
      expect(AddWatchlist(testMovieDetail).props, [testMovieDetail]);
      expect(RemoveFromWatchlist(testMovieDetail).props, [testMovieDetail]);
      expect(LoadWatchlistStatus(tId).props, [tId]);
    });

    blocTest<MovieWatchlistDetailBloc, MovieWatchlistDetailState>(
      'Should emit [Received] when data is saved successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
            Right(MovieWatchlistDetailBloc.watchlistAddSuccessMessage));
        return movieWatchlistDetailBloc;
      },
      act: (detail) => detail.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        LoadingStatus(),
        ReceivedStatus(
            true, MovieWatchlistDetailBloc.watchlistAddSuccessMessage),
      ],
      verify: (detail) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistDetailBloc, MovieWatchlistDetailState>(
      'Should emit [Error] when save data is unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return movieWatchlistDetailBloc;
      },
      act: (detail) => detail.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        LoadingStatus(),
        ErrorStatus('Database Failure'),
      ],
      verify: (detail) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistDetailBloc, MovieWatchlistDetailState>(
      'Should emit [Received] when data is removed successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                Right(MovieWatchlistDetailBloc.watchlistRemoveSuccessMessage));
        return movieWatchlistDetailBloc;
      },
      act: (detail) => detail.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        LoadingStatus(),
        ReceivedStatus(
            false, MovieWatchlistDetailBloc.watchlistRemoveSuccessMessage),
      ],
      verify: (detail) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistDetailBloc, MovieWatchlistDetailState>(
      'Should emit [Error] when remove data is unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return movieWatchlistDetailBloc;
      },
      act: (detail) => detail.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        LoadingStatus(),
        ErrorStatus('Database Failure'),
      ],
      verify: (detail) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
    blocTest<MovieWatchlistDetailBloc, MovieWatchlistDetailState>(
      'Should emit [Received] when get status',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieWatchlistDetailBloc;
      },
      act: (detail) => detail.add(LoadWatchlistStatus(tId)),
      expect: () => [
        ReceivedStatus(true, ''),
      ],
      verify: (detail) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
  });
}
