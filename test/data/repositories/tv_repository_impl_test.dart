import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/tv_series/data/models/tv_createdby_model.dart';
import 'package:ditonton/tv_series/data/models/tv_detail_model.dart';
import 'package:ditonton/tv_series/data/models/tv_episode_model.dart';
import 'package:ditonton/tv_series/data/models/tv_last_episode_model.dart';
import 'package:ditonton/tv_series/data/models/tv_model.dart';
import 'package:ditonton/tv_series/data/models/tv_network_model.dart';
import 'package:ditonton/tv_series/data/models/tv_production_country_model.dart';
import 'package:ditonton/tv_series/data/models/tv_season_model.dart';
import 'package:ditonton/tv_series/data/models/tv_spoken_language_model.dart';
import 'package:ditonton/tv_series/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvModel = TvModel(
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    firstAirDate: DateTime.parse("2011-04-17"),
    genreIds: [10765, 10759, 18],
    id: 1399,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    originCountry: ["US"],
    originalLanguage: "en",
    popularity: 29.780826,
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTv = Tv(
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    popularity: 29.780826,
    id: 1399,
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    voteAverage: 7.91,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    firstAirDate: DateTime.parse("2011-04-17"),
    originCountry: ["US"],
    genreIds: [10765, 10759, 18],
    originalLanguage: "en",
    voteCount: 1172,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Airing Today Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvAiringToday())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTvAiringToday();
      // assert
      verify(mockRemoteDataSource.getTvAiringToday());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvAiringToday())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvAiringToday();
      // assert
      verify(mockRemoteDataSource.getTvAiringToday());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvAiringToday())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvAiringToday();
      // assert
      verify(mockRemoteDataSource.getTvAiringToday());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(result, Left(ServerFailure('')));
    });
    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailModel(
      backdropPath: 'backdropPath',
      createdBy: [
        CreatedByModel(
          id: 1,
          creditId: 'creditId',
          name: 'name',
          gender: 1,
          profilePath: 'profilePath',
        )
      ],
      episodeRunTime: [1, 2],
      firstAirDate: DateTime.parse("2014-04-14"),
      genres: [
        GenreModel(
          id: 1,
          name: 'Action',
        ),
      ],
      homepage: 'homepage',
      id: 1,
      inProduction: true,
      languages: ['aa', 'bb'],
      lastAirDate: DateTime.parse("2014-04-14"),
      lastEpisodeToAir: TVLastEpisodesToAirModel(
        airDate: DateTime.parse("2014-04-14"),
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 0,
        voteCount: 1,
      ),
      name: 'name',
      nextEpisodeToAir: 12,
      networks: [
        TvNetworkModel(
          name: 'name',
          id: 1,
          logoPath: 'logoPath',
          originCountry: 'originCountry',
        )
      ],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['aa'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.1,
      posterPath: 'posterPath',
      productionCompanies: [
        TvNetworkModel(
          name: 'name',
          id: 1,
          logoPath: 'logoPath',
          originCountry: 'originCountry',
        )
      ],
      productionCountries: [
        TvProductionCountryModel(
          iso31661: 'iso31661',
          name: 'name',
        )
      ],
      seasons: [
        TvSeasonModel(
          airDate: DateTime.parse("2014-04-14"),
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        ),
      ],
      spokenLanguages: [
        TvSpokenLanguageModel(
          englishName: 'englishName',
          iso6391: 'iso6391',
          name: 'name',
        )
      ],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1.1,
      voteCount: 1,
    );

    test(
        'should return tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailTVs(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getDetailTVs(tId);
      // assert
      verify(mockRemoteDataSource.getDetailTVs(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailTVs(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getDetailTVs(tId);
      // assert
      verify(mockRemoteDataSource.getDetailTVs(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailTVs(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetailTVs(tId);
      // assert
      verify(mockRemoteDataSource.getDetailTVs(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Episodes', () {
    final tTvEpisodeList = <TvEpisodeModel>[];
    final tIdTv = 1;
    final tSeasonNumber = 1;

    test('should return data (episode list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeasonEpisodes(tIdTv, tSeasonNumber))
          .thenAnswer((_) async => tTvEpisodeList);
      // act
      final result = await repository.getTvSeasonEpisodes(tIdTv, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvSeasonEpisodes(tIdTv, tSeasonNumber));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvEpisodeList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeasonEpisodes(tIdTv, tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeasonEpisodes(tIdTv, tSeasonNumber);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeasonEpisodes(tIdTv, tSeasonNumber));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeasonEpisodes(tIdTv, tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeasonEpisodes(tIdTv, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvSeasonEpisodes(tIdTv, tSeasonNumber));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'game of thrones';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTv(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTv(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isTvAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of tv series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVs())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTVs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
