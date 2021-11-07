import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_repository.dart';

class GetWatchListTVs {
  final TvRepository repository;
  GetWatchListTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTVs();
  }
}
