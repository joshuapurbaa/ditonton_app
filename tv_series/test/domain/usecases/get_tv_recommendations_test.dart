import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTvRecommendations getTvRecommendations;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvRecommendations = GetTvRecommendations(mockTvRepository);
  });

  final tId = 1;
  final tTVs = <Tv>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await getTvRecommendations.execute(tId);
    // assert
    expect(result, Right(tTVs));
  });
}
