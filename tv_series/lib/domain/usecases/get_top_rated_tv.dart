import 'package:core/tv_series/domain/entities/tv.dart';
import 'package:core/tv_series/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTVs {
  final TvRepository repository;
  GetTopRatedTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTVs();
  }
}
