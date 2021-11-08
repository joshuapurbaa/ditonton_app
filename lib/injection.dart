import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/tv_series/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/tv_series/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_repository.dart';
import 'package:ditonton/tv_series/domain/usecase/get_tv_recommendations.dart';
import 'package:ditonton/tv_series/domain/usecase/get_tv_season_eps.dart';
import 'package:ditonton/tv_series/domain/usecase/get_watchlist_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/search_tv.dart';
import 'package:ditonton/tv_series/presentation/provider/detail_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation/provider/popular_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation/provider/list_tv_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/tv_series/domain/usecase/get_detail_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/get_popular_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/get_top_rated_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/get_tv_airing_today.dart';
import 'package:ditonton/tv_series/domain/usecase/get_watchlist_tv_status.dart';
import 'package:ditonton/tv_series/domain/usecase/remove_watchlist_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/save_watchlist_tv.dart';
import 'package:ditonton/tv_series/presentation/provider/search_tv_notifier.dart';

import 'package:ditonton/tv_series/presentation/provider/top_rated_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation/provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider

  // Movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

// TV Series
  locator.registerFactory(
    () => TVListNotifier(
      getTvAiringToday: locator(),
      getPopularTVs: locator(),
      getTopRatedTVs: locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailNotifier(
      getDetailTVs: locator(),
      getTvRecommendations: locator(),
      getTvWatchListStatus: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchListTVs: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTVs: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvNotifier(
      getPopularTVs: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSearchNotifier(
      searchTVs: locator(),
    ),
  );
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // Tv Series usecase
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetPopularTVs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVs(locator()));
  locator.registerLazySingleton(() => GetDetailTVs(locator()));
  locator.registerLazySingleton(() => GetTvWatchListStatus(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));
  locator.registerLazySingleton(() => GetWatchListTVs(locator()));
  locator.registerLazySingleton(() => GetTvSeasonEpisodes(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
