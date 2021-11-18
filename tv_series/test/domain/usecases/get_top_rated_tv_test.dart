import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTopRatedTVs getTopRatedTVs;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTopRatedTVs = GetTopRatedTVs(mockTvRepository);
  });

  final tTVs = <Tv>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTVs())
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await getTopRatedTVs.execute();
    // assert
    expect(result, Right(tTVs));
  });
}
