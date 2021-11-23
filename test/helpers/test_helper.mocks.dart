// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:core/core.dart' as _i6;
import 'package:core/utils/failure.dart' as _i11;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/data/datasource/movie_local_data_source.dart' as _i16;
import 'package:movies/data/datasource/movie_remote_data_source.dart' as _i14;
import 'package:movies/data/models/movie_detail_model.dart' as _i3;
import 'package:movies/data/models/movie_model.dart' as _i15;
import 'package:movies/data/models/movie_table.dart' as _i9;
import 'package:movies/domain/entities/movie.dart' as _i12;
import 'package:movies/domain/entities/movie_detail.dart' as _i13;
import 'package:movies/domain/repositories/movie_repository.dart' as _i10;
import 'package:sqflite/sqflite.dart' as _i8;
import 'package:tv_series/tv_series.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvDetailModel_2 extends _i1.Fake implements _i4.TvDetailModel {}

class _FakeTvSeasonModel_3 extends _i1.Fake implements _i4.TvSeasonModel {}

class _FakeTvEpisodeModel_4 extends _i1.Fake implements _i4.TvEpisodeModel {}

class _FakeResponse_5 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_6 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i6.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i8.Database?> get database => (super.noSuchMethod(
      Invocation.getter(#database),
      returnValue: Future<_i8.Database?>.value()) as _i7.Future<_i8.Database?>);
  @override
  _i7.Future<void> insertCacheTransactionMovie(
          List<_i9.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransactionMovie, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCacheMovie(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCacheMovie, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlistMovie(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistMovie, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistMovie(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistMovie, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<void> insertCacheTransactionTv(
          List<_i4.TvTable>? cTv, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransactionTv, [cTv, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheTv(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheTv, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCacheTv(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCacheTv, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlistTv(_i4.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tv]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistTv(_i4.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tv]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTVs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVs, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i10.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>.value(
              _FakeEither_0<_i11.Failure, List<_i12.Movie>>())) as _i7
          .Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>.value(
              _FakeEither_0<_i11.Failure, List<_i12.Movie>>())) as _i7
          .Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>.value(
              _FakeEither_0<_i11.Failure, List<_i12.Movie>>())) as _i7
          .Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i13.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i11.Failure, _i13.MovieDetail>>.value(
              _FakeEither_0<_i11.Failure, _i13.MovieDetail>())) as _i7
          .Future<_i2.Either<_i11.Failure, _i13.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>.value(
              _FakeEither_0<_i11.Failure, List<_i12.Movie>>())) as _i7
          .Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>.value(
              _FakeEither_0<_i11.Failure, List<_i12.Movie>>())) as _i7
          .Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> saveWatchlist(
          _i13.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i11.Failure, String>>.value(
                  _FakeEither_0<_i11.Failure, String>()))
          as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> removeWatchlist(
          _i13.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i11.Failure, String>>.value(
                  _FakeEither_0<_i11.Failure, String>()))
          as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>.value(
              _FakeEither_0<_i11.Failure, List<_i12.Movie>>())) as _i7
          .Future<_i2.Either<_i11.Failure, List<_i12.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i14.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i15.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<List<_i15.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
      as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<List<_i15.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
      as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i15.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i7.Future<List<_i15.MovieModel>>);
  @override
  _i7.Future<List<_i15.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i7.Future<List<_i15.MovieModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i16.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i9.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i9.MovieTable?>.value())
          as _i7.Future<_i9.MovieTable?>);
  @override
  _i7.Future<List<_i9.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]))
      as _i7.Future<List<_i9.MovieTable>>);
  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i9.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]))
          as _i7.Future<List<_i9.MovieTable>>);
  @override
  _i7.Future<void> cachePopularMovies(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cachePopularMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i9.MovieTable>> getCachedPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedPopularMovies, []),
              returnValue:
                  Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]))
          as _i7.Future<List<_i9.MovieTable>>);
  @override
  _i7.Future<void> cacheTopRatedMovies(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheTopRatedMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i9.MovieTable>> getCachedTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedTopRatedMovies, []),
              returnValue:
                  Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]))
          as _i7.Future<List<_i9.MovieTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i4.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>> getAiringTodayTv() =>
      (super.noSuchMethod(Invocation.method(#getAiringTodayTv, []),
              returnValue: Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>.value(
                  _FakeEither_0<_i11.Failure, List<_i4.Tv>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>> getPopularTVs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVs, []),
              returnValue: Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>.value(
                  _FakeEither_0<_i11.Failure, List<_i4.Tv>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>> getTopRatedTVs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVs, []),
              returnValue: Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>.value(
                  _FakeEither_0<_i11.Failure, List<_i4.Tv>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i4.TvDetail>> getDetailTVs(int? id) =>
      (super.noSuchMethod(Invocation.method(#getDetailTVs, [id]),
              returnValue: Future<_i2.Either<_i11.Failure, _i4.TvDetail>>.value(
                  _FakeEither_0<_i11.Failure, _i4.TvDetail>()))
          as _i7.Future<_i2.Either<_i11.Failure, _i4.TvDetail>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>.value(
                  _FakeEither_0<_i11.Failure, List<_i4.Tv>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i4.TvSeason>> getTvSeasonDetail(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvSeasonDetail, [id, seasonNumber]),
              returnValue: Future<_i2.Either<_i11.Failure, _i4.TvSeason>>.value(
                  _FakeEither_0<_i11.Failure, _i4.TvSeason>()))
          as _i7.Future<_i2.Either<_i11.Failure, _i4.TvSeason>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i4.TvEpisode>> getTvEpisodesDetail(
          int? id, int? seasonNumber, int? episodeNumber) =>
      (super.noSuchMethod(
          Invocation.method(
              #getTvEpisodesDetail, [id, seasonNumber, episodeNumber]),
          returnValue: Future<_i2.Either<_i11.Failure, _i4.TvEpisode>>.value(
              _FakeEither_0<_i11.Failure, _i4.TvEpisode>())) as _i7
          .Future<_i2.Either<_i11.Failure, _i4.TvEpisode>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>> searchTVs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVs, [query]),
              returnValue: Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>.value(
                  _FakeEither_0<_i11.Failure, List<_i4.Tv>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> saveWatchlistTv(
          _i4.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistTv, [tv]),
              returnValue: Future<_i2.Either<_i11.Failure, String>>.value(
                  _FakeEither_0<_i11.Failure, String>()))
          as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> removeWatchlistTv(
          _i4.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tv]),
              returnValue: Future<_i2.Either<_i11.Failure, String>>.value(
                  _FakeEither_0<_i11.Failure, String>()))
          as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<bool> isTvAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isTvAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>> getWatchlistTVs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVs, []),
              returnValue: Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>.value(
                  _FakeEither_0<_i11.Failure, List<_i4.Tv>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i4.Tv>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i4.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i4.TvModel>> getTvAiringToday() =>
      (super.noSuchMethod(Invocation.method(#getTvAiringToday, []),
              returnValue: Future<List<_i4.TvModel>>.value(<_i4.TvModel>[]))
          as _i7.Future<List<_i4.TvModel>>);
  @override
  _i7.Future<List<_i4.TvModel>> getPopularTVs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVs, []),
              returnValue: Future<List<_i4.TvModel>>.value(<_i4.TvModel>[]))
          as _i7.Future<List<_i4.TvModel>>);
  @override
  _i7.Future<List<_i4.TvModel>> getTopRatedTVs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVs, []),
              returnValue: Future<List<_i4.TvModel>>.value(<_i4.TvModel>[]))
          as _i7.Future<List<_i4.TvModel>>);
  @override
  _i7.Future<_i4.TvDetailModel> getDetailTVs(int? id) => (super.noSuchMethod(
          Invocation.method(#getDetailTVs, [id]),
          returnValue: Future<_i4.TvDetailModel>.value(_FakeTvDetailModel_2()))
      as _i7.Future<_i4.TvDetailModel>);
  @override
  _i7.Future<List<_i4.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<List<_i4.TvModel>>.value(<_i4.TvModel>[]))
          as _i7.Future<List<_i4.TvModel>>);
  @override
  _i7.Future<_i4.TvSeasonModel> getTvSeasonDetail(int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvSeasonDetail, [id, seasonNumber]),
              returnValue:
                  Future<_i4.TvSeasonModel>.value(_FakeTvSeasonModel_3()))
          as _i7.Future<_i4.TvSeasonModel>);
  @override
  _i7.Future<_i4.TvEpisodeModel> getTvEpisodesDetail(
          int? id, int? seasonNumber, int? episodeNumber) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getTvEpisodesDetail, [id, seasonNumber, episodeNumber]),
              returnValue:
                  Future<_i4.TvEpisodeModel>.value(_FakeTvEpisodeModel_4()))
          as _i7.Future<_i4.TvEpisodeModel>);
  @override
  _i7.Future<List<_i4.TvModel>> searchTVs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVs, [query]),
              returnValue: Future<List<_i4.TvModel>>.value(<_i4.TvModel>[]))
          as _i7.Future<List<_i4.TvModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i4.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistTv(_i4.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tv]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistTv(_i4.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tv]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i4.TvTable?> getTvSeriesById(int? id) => (super.noSuchMethod(
      Invocation.method(#getTvSeriesById, [id]),
      returnValue: Future<_i4.TvTable?>.value()) as _i7.Future<_i4.TvTable?>);
  @override
  _i7.Future<List<_i4.TvTable>> getWatchlistTVs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVs, []),
              returnValue: Future<List<_i4.TvTable>>.value(<_i4.TvTable>[]))
          as _i7.Future<List<_i4.TvTable>>);
  @override
  _i7.Future<void> cacheTv(List<_i4.TvTable>? cTv, String? categories) =>
      (super.noSuchMethod(Invocation.method(#cacheTv, [cTv, categories]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i4.TvTable>> getCacheTv(String? categories) =>
      (super.noSuchMethod(Invocation.method(#getCacheTv, [categories]),
              returnValue: Future<List<_i4.TvTable>>.value(<_i4.TvTable>[]))
          as _i7.Future<List<_i4.TvTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_5()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_5()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_5()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_5()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_5()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_5()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i18.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i18.Uint8List>.value(_i18.Uint8List(0)))
          as _i7.Future<_i18.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_6()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}