import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late MockNetworkInfo mockNetworkInfo;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MockMovieLocalDataSource mockMovieLocalDataSource;
  late MovieLocalDataSourceImpl movieLocalDataSourceImpl;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    mockNetworkInfo = MockNetworkInfo();
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockMovieLocalDataSource = MockMovieLocalDataSource();
    movieLocalDataSourceImpl =
        MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
    movieRepositoryImpl = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource,
      localDataSource: mockMovieLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('Exception test', () {
    test('Throw DatabaseException test', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistMovie(testMovieTable))
          .thenThrow(DatabaseException(''));
      // act
      final call = movieLocalDataSourceImpl.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Failure test', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('DatabaseFailure tests', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await movieRepositoryImpl.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });

    test('ServerFailure tests', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(1))
          .thenThrow(ServerException());
      // act
      final result = await movieRepositoryImpl.getMovieRecommendations(1);
      // assert
      verify(mockMovieRemoteDataSource.getMovieRecommendations(1));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('ConnectionFailure tests', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(1))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await movieRepositoryImpl.getMovieDetail(1);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(1));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
