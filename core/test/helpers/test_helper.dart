import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/tv_series/data/datasources/tv_local_data_source.dart';
import 'package:core/tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:core/tv_series/domain/repositories/tv_repository.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  DatabaseHelper,
  NetworkInfo,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
