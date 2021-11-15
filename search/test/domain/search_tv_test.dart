import 'package:tv_series/tv_series.dart';

import '../../lib/domain/usecases/search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../tv_series/test/helpers/test_helpers.mocks.dart';

void main() {
  late SearchTVs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTVs(mockTvRepository);
  });

  final tTVs = <Tv>[];
  final tQuery = 'game of thrones';

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.searchTVs(tQuery))
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVs));
  });
}
