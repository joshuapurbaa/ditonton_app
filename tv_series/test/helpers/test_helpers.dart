import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    DatabaseHelper,
    TvRepository,
    TvRemoteDataSource,
    TvLocalDataSource,
    NetworkInfo,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
