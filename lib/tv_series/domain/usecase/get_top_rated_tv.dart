import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTopRatedTVs {
  final TvRepository repository;
  GetTopRatedTVs({required this.repository});

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTVs();
  }
}
