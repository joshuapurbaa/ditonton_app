import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetTopRatedTVs {
  final TvRepository repository;
  GetTopRatedTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTVs();
  }
}
