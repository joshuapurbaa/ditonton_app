import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final tMovieTableId = testMovieTable.id;
  final futureMovieId = (_) async => tMovieTableId;

  final tTvTableId = testTvTable.id;
  final futureTVInt = (_) async => tTvTableId;

  group('Movie database', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistMovie(testMovieTable))
          .thenAnswer(futureMovieId);
      // act
      final result =
          await mockDatabaseHelper.insertWatchlistMovie(testMovieTable);
      // assert
      expect(result, tMovieTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistMovie(testMovieTable))
          .thenAnswer(futureMovieId);
      // act
      final result =
          await mockDatabaseHelper.removeWatchlistMovie(testMovieTable);
      // assert
      expect(result, tMovieTableId);
    });

    test('should return movie detail table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tMovieTableId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await mockDatabaseHelper.getMovieById(tMovieTableId);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tMovieTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getMovieById(tMovieTableId);
      // assert
      expect(result, null);
    });

    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistMovies();
      // assert
      expect(result, [testMovieMap]);
    });
  });

  group('Tv series database', () {
    test('should return tv  id when inserting new tv ', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer(futureTVInt);
      // act
      final result = await mockDatabaseHelper.insertWatchlistTv(testTvTable);
      // assert
      expect(result, tTvTableId);
    });

    test('should return tv  id when deleting a tv ', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer(futureTVInt);
      // act
      final result = await mockDatabaseHelper.removeWatchlistTv(testTvTable);
      // assert
      expect(result, tTvTableId);
    });

    test('should return tv detail table when getting tv  by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tTvTableId))
          .thenAnswer((_) async => testTvTable.toJson());
      // act
      final result = await mockDatabaseHelper.getTvSeriesById(tTvTableId);
      // assert
      expect(result, testTvTable.toJson());
    });

    test('should return null when getting tv  by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tTvTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getTvSeriesById(tTvTableId);
      // assert
      expect(result, null);
    });

    test('should return list of tv  map when getting watchlist tv s', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTVs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistTVs();
      // assert
      expect(result, [testTvMap]);
    });
  });
}
