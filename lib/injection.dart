import 'package:core/core.dart';
import 'package:core/presentation/watchlist_bloc/watchlist_tv_bloc.dart';
import 'package:movies/domain/usecase/get_movie_detail.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_watchlist_detail_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/search.dart';
import 'package:core/data/datasources/db/database_helper.dart';

import 'package:core/presentation/watchlist_bloc/watchlist_movie_bloc.dart';
import 'package:movies/presentation/bloc/movie_home_bloc/movie_home_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_watchlist_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_episode_bloc/tv_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_home_bloc/tv_home_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  // BLOC
  locator.registerFactory(
    () => SearchMovieBloc(locator()),
  );

  locator.registerFactory(
    () => SearchTvBloc(locator()),
  );

  locator.registerFactory(
    () => NowPlayingMovieHomeBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMovieHomeBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMovieHomeBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieRecommendationsBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistDetailBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => AiringTodayTvHomeBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvHomeBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvHomeBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvRecommendationsBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeasonBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvEpisodeBloc(
      locator(),
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
  locator.registerLazySingleton(() => GetEpisodeTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeasonDetail(locator()));

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
      networkInfo: locator(),
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
