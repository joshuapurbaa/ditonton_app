import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetPopularTVs getPopularTVs;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getPopularTVs = GetPopularTVs(mockTvRepository);
  });

  final tTVs = <Tv>[];

  group('GetPopularTV Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTVs())
            .thenAnswer((_) async => Right(tTVs));
        // act
        final result = await getPopularTVs.execute();
        // assert
        expect(result, Right(tTVs));
      });
    });
  });
}
