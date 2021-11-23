import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/data/datasource/movie_local_data_source.dart';
import 'package:movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:tv_series/data/datasources/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    DatabaseHelper,
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    TvRepository,
    TvRemoteDataSource,
    TvLocalDataSource,
    NetworkInfo,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
