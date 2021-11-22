import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetEpisodeTvDetail {
  final TvRepository tvRepository;

  GetEpisodeTvDetail(this.tvRepository);

  Future<Either<Failure, TvEpisode>> execute(id, seasonNumber, episodeNumber) {
    return tvRepository.getTvEpisodesDetail(id, seasonNumber, episodeNumber);
  }
}
