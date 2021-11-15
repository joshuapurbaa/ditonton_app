import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class SearchTVs {
  final TvRepository repository;
  SearchTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTVs(query);
  }
}
