import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetDetailTVs {
  final TvRepository repository;
  GetDetailTVs(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getDetailTVs(id);
  }
}
