import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;
  GetTvSeasonEpisodes(this.repository);

  Future<Either<Failure, List<TvEpisode>>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
