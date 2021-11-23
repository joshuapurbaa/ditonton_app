import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_episode_tv_detail.dart';
import 'package:tv_series/presentation/bloc/tv_episode_bloc/tv_episode_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_episode_bloc_test.mocks.dart';

@GenerateMocks([GetEpisodeTvDetail])
void main() {
  late TvEpisodeBloc tvEpisodeBloc;
  late MockGetEpisodeTvDetail mockGetEpisodeTvDetail;

  setUp(() {
    mockGetEpisodeTvDetail = MockGetEpisodeTvDetail();
    tvEpisodeBloc = TvEpisodeBloc(mockGetEpisodeTvDetail);
  });

  final tId = 1;
  group('Get tv episode', () {
    test('initial state should be empty', () {
      expect(tvEpisodeBloc.state, EpisodeEmpty());
      expect(FetchEpisodeData(tId, tId, tId).props, [tId, tId, tId]);
    });

    blocTest<TvEpisodeBloc, TvEpisodeState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetEpisodeTvDetail.execute(tId, tId, tId))
            .thenAnswer((_) async => Right(testEpisodeTvDetail));
        return tvEpisodeBloc;
      },
      act: (bloc) => bloc.add(FetchEpisodeData(tId, tId, tId)),
      expect: () => [
        EpisodeLoading(),
        EpisodeHasData(testEpisodeTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetEpisodeTvDetail.execute(tId, tId, tId));
      },
    );

    blocTest<TvEpisodeBloc, TvEpisodeState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetEpisodeTvDetail.execute(tId, tId, tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvEpisodeBloc;
      },
      act: (bloc) => bloc.add(FetchEpisodeData(tId, tId, tId)),
      expect: () => [
        EpisodeLoading(),
        EpisodeError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetEpisodeTvDetail.execute(tId, tId, tId));
      },
    );
  });
}
