import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class GetDetailTVs {
  final TvRepository repository;
  GetDetailTVs(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getDetailTVs(id);
  }
}
