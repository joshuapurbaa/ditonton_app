import 'dart:io';

import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/domain/entities/tv_season.dart';

import '../../data/datasources/tv_local_data_source.dart';
import '../../data/datasources/tv_remote_data_source.dart';
import '../../data/models/tv_table_model.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tv>>> getAiringTodayTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvAiringToday();
        localDataSource.cacheTv(
            result.map((movie) => TvTable.fromDTO(movie)).toList(),
            'airingtoday');
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCacheTv('airingtoday');
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getDetailTVs(int id) async {
    try {
      final result = await remoteDataSource.getDetailTVs(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTVs() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTVs();
        localDataSource.cacheTv(
            result.map((movie) => TvTable.fromDTO(movie)).toList(),
            'popular tv');
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCacheTv('popular tv');
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTVs() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTVs();
        localDataSource.cacheTv(
            result.map((movie) => TvTable.fromDTO(movie)).toList(),
            'top rated tv');
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCacheTv('top rated tv');
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTVs() async {
    final result = await localDataSource.getWatchlistTVs();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isTvAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTVs(String query) async {
    try {
      final result = await remoteDataSource.searchTVs(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvEpisode>> getTvEpisodesDetail(
      int id, int seasonNumber, int episodeNumber) async {
    try {
      final result = await remoteDataSource.getTvEpisodesDetail(
          id, seasonNumber, episodeNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeason>> getTvSeasonDetail(
      int id, int seasonNumber) async {
    try {
      final result = await remoteDataSource.getTvSeasonDetail(id, seasonNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
