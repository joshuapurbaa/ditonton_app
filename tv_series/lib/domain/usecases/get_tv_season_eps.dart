import 'package:core/tv_series/domain/entities/tv_episode.dart';
import 'package:core/tv_series/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;
  GetTvSeasonEpisodes(this.repository);

  Future<Either<Failure, List<TvEpisode>>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
