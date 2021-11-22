import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_season_tv_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTvSeasonDetail getTvSeasonDetail;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvSeasonDetail = GetTvSeasonDetail(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeasonDetail(tId, tId))
        .thenAnswer((_) async => Right(testSeasonTvDetail));
    // act
    final result = await getTvSeasonDetail.execute(tId, tId);
    // assert
    expect(result, Right(testSeasonTvDetail));
  });
}
