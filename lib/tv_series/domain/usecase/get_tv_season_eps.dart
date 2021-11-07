import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../entities/tv_episode.dart';
import '../repositories/tv_repository.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;
  GetTvSeasonEpisodes({required this.repository});

  Future<Either<Failure, List<TvEpisode>>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
