// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tv_series/domain/usecases/get_tv_season_eps.dart';

// import '../../dummy_data/dummy_objects.dart';
// import '../../helpers/test_helpers.mocks.dart';

// void main() {
//   late GetTvSeasonEpisodes getTvSeasonEpisodes;
//   late MockTvRepository mockTvRepository;

//   setUp(() {
//     mockTvRepository = MockTvRepository();
//     getTvSeasonEpisodes = GetTvSeasonEpisodes(mockTvRepository);
//   });

//   final tId = 1;

//   test('should get tv detail from the repository', () async {
//     // arrange
//     when(mockTvRepository.getTvSeasonEpisodes(tId, tId))
//         .thenAnswer((_) async => Right(testTvEpisodes));
//     // act
//     final result = await getTvSeasonEpisodes.execute(tId, tId);
//     // assert
//     expect(result, Right(testTvEpisodes));
//   });
// }
