import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetPopularTVs {
  final TvRepository repository;
  GetPopularTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTVs();
  }
}
