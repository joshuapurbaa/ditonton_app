import 'package:core/core.dart';
import 'package:core/tv_series/domain/entities/tv.dart';
import 'package:core/tv_series/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SearchTVs {
  final TvRepository repository;
  SearchTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTVs(query);
  }
}
