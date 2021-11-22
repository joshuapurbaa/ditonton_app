import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTv(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTv(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tvs', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTVs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTVs();
      // assert
      expect(result, [testTvTable]);
    });
  });

  group('cache tvs section', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTv('airingtoday'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheTv([testTvCache], 'airingtoday');
      // assert
      verify(mockDatabaseHelper.clearCacheTv('airingtoday'));
      verify(mockDatabaseHelper
          .insertCacheTransactionTv([testTvCache], 'airingtoday'));
    });

    test('should return list of tvs from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTv('airingtoday'))
          .thenAnswer((_) async => [testTvCacheMap]);
      // act
      final result = await dataSource.getCacheTv('airingtoday');
      // assert
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTv('airingtoday'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCacheTv('airingtoday');
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
