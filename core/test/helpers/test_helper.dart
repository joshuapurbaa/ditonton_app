import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';

@GenerateMocks([
  DatabaseHelper,
  NetworkInfo,
  MovieRepositoryImpl,
  MovieRemoteDataSource,
  MovieLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}
