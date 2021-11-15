import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetWatchListTVs {
  final TvRepository repository;
  GetWatchListTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTVs();
  }
}
