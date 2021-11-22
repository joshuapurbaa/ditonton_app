import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_airing_today.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTvAiringToday getTvAiringToday;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvAiringToday = GetTvAiringToday(mockTvRepository);
  });

  final tTVs = <Tv>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getAiringTodayTv())
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await getTvAiringToday.execute();
    // assert
    expect(result, Right(tTVs));
  });
}
