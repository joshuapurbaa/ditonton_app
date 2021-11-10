import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetPopularTVs {
  final TvRepository repository;
  GetPopularTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTVs();
  }
}