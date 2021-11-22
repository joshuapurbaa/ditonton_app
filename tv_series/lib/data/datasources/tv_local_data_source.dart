import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/exception.dart';
import 'package:tv_series/data/models/tv_table_model.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tv);
  Future<String> removeWatchlistTv(TvTable tv);
  Future<TvTable?> getTvSeriesById(int id);
  Future<List<TvTable>> getWatchlistTVs();
  Future<void> cacheTv(List<TvTable> cTv, String categories);
  Future<List<TvTable>> getCacheTv(String categories);
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTv(TvTable tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTVs() async {
    final result = await databaseHelper.getWatchlistTVs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheTv(List<TvTable> cTv, String categories) async {
    await databaseHelper.clearCacheTv(categories);
    await databaseHelper.insertCacheTransactionTv(cTv, categories);
  }

  @override
  Future<List<TvTable>> getCacheTv(String categories) async {
    final result = await databaseHelper.getCacheTv(categories);
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can'nt get the data :(");
    }
  }
}
