import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetTvSeasonDetail {
  final TvRepository tvRepository;
  GetTvSeasonDetail(this.tvRepository);

  Future<Either<Failure, TvSeason>> execute(int id, int seasonNumber) {
    return tvRepository.getTvSeasonDetail(id, seasonNumber);
  }
}
