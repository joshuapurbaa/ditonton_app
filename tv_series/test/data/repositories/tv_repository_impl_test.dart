import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/models/tv_crew_model.dart';
import 'package:tv_series/data/models/tv_episodes_detail_model.dart';
import 'package:tv_series/data/models/tv_guest_star_model.dart';
import 'package:tv_series/data/models/tv_season_detail_model.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTvModel = TvModel(
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    firstAirDate: "2011-04-17",
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
    firstAirDate: "2011-04-17",
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
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTvAiringToday()).thenAnswer((_) async => []);
      // act
      await repository.getAiringTodayTv();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data when the call to data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvAiringToday())
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockRemoteDataSource.getTvAiringToday());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvAiringToday())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getAiringTodayTv();
        // assert
        verify(mockRemoteDataSource.getTvAiringToday());
        verify(mockLocalDataSource.cacheTv([testTvCache], 'airingtoday'));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvAiringToday())
            .thenThrow(ServerException());
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockRemoteDataSource.getTvAiringToday());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCacheTv('airingtoday'))
            .thenAnswer((_) async => [testTvCache]);
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockLocalDataSource.getCacheTv('airingtoday'));
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCacheTv('airingtoday'))
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockLocalDataSource.getCacheTv('airingtoday'));
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Tv Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularTVs()).thenAnswer((_) async => []);
      // act
      await repository.getPopularTVs();
      // assert
      verify(mockNetworkInfo.isConnected);
    });
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data when the call to data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTVs())
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getPopularTVs();
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTVs())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getPopularTVs();
        // assert
        verify(mockRemoteDataSource.getPopularTVs());
        verify(mockLocalDataSource.cacheTv([testTvCache], 'popular tv'));
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
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCacheTv('popular tv'))
            .thenAnswer((_) async => [testTvCache]);
        // act
        final result = await repository.getPopularTVs();
        // assert
        verify(mockLocalDataSource.getCacheTv('popular tv'));
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCacheTv('popular tv'))
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getPopularTVs();
        // assert
        verify(mockLocalDataSource.getCacheTv('popular tv'));
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Top Rated Tv Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedTVs()).thenAnswer((_) async => []);
      // act
      await repository.getTopRatedTVs();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTVs())
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getTopRatedTVs();
        final resultList = result.getOrElse(() => []);
        // assert
        verify(mockRemoteDataSource.getTopRatedTVs());
        expect(resultList, tTvList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTVs())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getTopRatedTVs();
        // assert
        verify(mockRemoteDataSource.getTopRatedTVs());
        verify(mockLocalDataSource.cacheTv([testTvCache], 'top rated tv'));
      });
      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTVs())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTVs();
        // assert
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCacheTv('top rated tv'))
            .thenAnswer((_) async => [testTvCache]);
        // act
        final result = await repository.getTopRatedTVs();
        // assert
        verify(mockLocalDataSource.getCacheTv('top rated tv'));
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCacheTv('top rated tv'))
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getTopRatedTVs();
        // assert
        verify(mockLocalDataSource.getCacheTv('top rated tv'));
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailModel(
      backdropPath: 'backdropPath',
      episodeRunTime: [1, 2],
      firstAirDate: "2014-04-14",
      genres: [
        GenreModel(
          id: 1,
          name: 'Action',
        ),
      ],
      homepage: 'homepage',
      id: 1,
      inProduction: true,
      lastAirDate: "2014-04-14",
      lastEpisodeToAir: TvEpisodesDetailModel(
        airDate: "2014-04-14",
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        stillPath: 'stillPath',
      ),
      name: 'name',
      nextEpisodeToAir: TvEpisodesDetailModel(
        airDate: "2014-04-14",
        episodeNumber: 2,
        id: 2,
        name: 'name',
        overview: 'overview',
        stillPath: 'stillPath',
      ),
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.1,
      posterPath: 'posterPath',
      seasons: [
        TvSeasonDetailModel(
          airDate: '2014-04-14',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        ),
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

  group('Get tv episodes detail', () {
    final tId = 1;
    final testDetailModel = TvEpisodeModel(
      airDate: "2011-04-17",
      crew: [
        CrewModel(
          id: 44797,
          creditId: "5256c8a219c2956ff6046e77",
          name: "Tim Van Patten",
          department: "Directing",
          job: "Director",
          profilePath: "/6b7l9YbkDHDOzOKUFNqBVaPjcgm.jpg",
        )
      ],
      episodeNumber: 1,
      guestStars: [
        GuestStarModel(
          id: 117642,
          name: "Jason Momoa",
          creditId: "5256c8a219c2956ff6046f40",
          character: "Khal Drogo",
          order: 0,
          profilePath: "/PSK6GmsVwdhqz9cd1lwzC6a7EA.jpg",
        ),
      ],
      name: "Winter Is Coming",
      overview:
          "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
      id: 63056,
      productionCode: "101",
      seasonNumber: 1,
      stillPath: "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg",
    );

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvEpisodesDetail(tId, tId, tId))
          .thenAnswer((_) async => testDetailModel);
      // act
      final result = await repository.getTvEpisodesDetail(tId, tId, tId);
      // assert
      verify(mockRemoteDataSource.getTvEpisodesDetail(tId, tId, tId));
      expect(result, equals(Right(testEpisodeTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvEpisodesDetail(tId, tId, tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvEpisodesDetail(tId, tId, tId);
      // assert
      verify(mockRemoteDataSource.getTvEpisodesDetail(tId, tId, tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvEpisodesDetail(tId, tId, tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvEpisodesDetail(tId, tId, tId);
      // assert
      verify(mockRemoteDataSource.getTvEpisodesDetail(tId, tId, tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get tv season detail', () {
    final tId = 1;
    final testSeasonDetail = TvSeasonModel(
      itemId: 'itemId',
      airDate: '2011-04-17',
      episodes: [
        TvEpisodeModel(
          airDate: '2011-04-17',
          crew: [
            CrewModel(
              id: 1,
              creditId: 'creditId',
              name: 'name',
              department: 'department',
              job: 'job',
              profilePath: 'profilePath',
            ),
          ],
          episodeNumber: 1,
          guestStars: [
            GuestStarModel(
              id: 1,
              name: 'name',
              creditId: 'creditId',
              character: 'character',
              order: 0,
              profilePath: 'profilePath',
            ),
          ],
          name: 'name',
          overview: "overview",
          id: 1,
          productionCode: '123',
          seasonNumber: 1,
          stillPath: 'stillPath',
        ),
      ],
      name: 'name',
      overview: 'overview',
      id: 1,
      posterPath: 'posterPath',
      seasonNumber: 1,
    );

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeasonDetail(tId, tId))
          .thenAnswer((_) async => testSeasonDetail);
      // act
      final result = await repository.getTvSeasonDetail(tId, tId);
      // assert
      verify(mockRemoteDataSource.getTvSeasonDetail(tId, tId));
      expect(result, equals(Right(testSeasonTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeasonDetail(tId, tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeasonDetail(tId, tId);
      // assert
      verify(mockRemoteDataSource.getTvSeasonDetail(tId, tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeasonDetail(tId, tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeasonDetail(tId, tId);
      // assert
      verify(mockRemoteDataSource.getTvSeasonDetail(tId, tId));
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
