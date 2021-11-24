import 'dart:async';

import 'package:core/utils/encrypt.dart';
import 'package:movies/data/models/movie_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import 'package:tv_series/tv_series.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  setDatabase(Database database) {
    _database = database;
  }

  static const String _tblWatchlistMovie = 'watchlistMovie';
  static const String _tblWatchlistTv = 'watchlistTv';
  static const String _tblMovieCache = 'movieCachae';
  static const String _tblTvCache = 'tvCache';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypts('@thejokratt136'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tblWatchlistMovie (
      id INTEGER PRIMARY KEY,
      title TEXT,
      overview TEXT,
      poster_path TEXT
    );
    ''');
    await db.execute('''
    CREATE TABLE $_tblWatchlistTv (
      id INTEGER PRIMARY KEY,
      name TEXT,
      overview TEXT,
      poster_path TEXT
    );
    ''');
    await db.execute('''
    CREATE TABLE $_tblMovieCache (
      id INTEGER PRIMARY KEY,
      title TEXT,
      poster_path TEXT,
      overview TEXT,
      category TEXT
    );
    ''');
    await db.execute('''
    CREATE TABLE $_tblTvCache (
      id INTEGER PRIMARY KEY,
      name TEXT,
      overview TEXT,
      poster_path TEXT,
      category TEXT
    );
    ''');
  }

  /* MOVIES */
  Future<void> insertCacheTransactionMovie(
    List<MovieTable> movies,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(
          _tblMovieCache,
          movieJson,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblMovieCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheMovie(String category) async {
    final db = await database;
    return await db!.delete(
      _tblMovieCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistMovie);

    return results;
  }

  /* TV SERIES */

  Future<void> insertCacheTransactionTv(
      List<TvTable> cTv, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tv in cTv) {
        final tvJson = tv.toJson();
        tvJson['category'] = category;
        txn.insert(
          _tblTvCache,
          tvJson,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTv(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblTvCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheTv(String category) async {
    final db = await database;
    return await db!.delete(
      _tblTvCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTVs() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);

    return results;
  }
}
