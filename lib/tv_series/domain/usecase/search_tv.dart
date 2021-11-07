import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class SearchTVs {
  final TvRepository repository;
  SearchTVs({required this.repository});

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTVs(query);
  }
}
