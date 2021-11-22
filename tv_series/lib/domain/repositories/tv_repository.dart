import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_season.dart';
import '../entities/tv_detail.dart';
import '../entities/tv_episode.dart';
import '../entities/tv.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getAiringTodayTv();
  Future<Either<Failure, List<Tv>>> getPopularTVs();
  Future<Either<Failure, List<Tv>>> getTopRatedTVs();
  Future<Either<Failure, TvDetail>> getDetailTVs(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, TvSeason>> getTvSeasonDetail(
    int id,
    int seasonNumber,
  );
  Future<Either<Failure, TvEpisode>> getTvEpisodesDetail(
      int id, int seasonNumber, int episodeNumber);
  Future<Either<Failure, List<Tv>>> searchTVs(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTVs();
}
