import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:ditonton/tv_series/domain/usecase/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTVs(repository: mockTvRepository);
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
