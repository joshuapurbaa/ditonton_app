import 'package:core/tv_series/domain/entities/tv_detail.dart';
import 'package:core/tv_series/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetDetailTVs {
  final TvRepository repository;
  GetDetailTVs(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getDetailTVs(id);
  }
}
