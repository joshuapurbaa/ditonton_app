import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_detail_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetDetailTVs getDetailTVs;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getDetailTVs = GetDetailTVs(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getDetailTVs(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await getDetailTVs.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}
