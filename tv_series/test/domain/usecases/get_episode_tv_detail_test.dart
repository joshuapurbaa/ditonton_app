import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_episode_tv_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetEpisodeTvDetail getEpisodeTvDetail;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getEpisodeTvDetail = GetEpisodeTvDetail(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvEpisodesDetail(tId, tId, tId))
        .thenAnswer((_) async => Right(testEpisodeTvDetail));
    // act
    final result = await getEpisodeTvDetail.execute(tId, tId, tId);
    // assert
    expect(result, Right(testEpisodeTvDetail));
  });
}
