import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_season_tv_detail.dart';
import 'package:tv_series/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_season_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonBloc tvSeasonBloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    tvSeasonBloc = TvSeasonBloc(mockGetTvSeasonDetail);
  });

  final tId = 1;

  group('Get tv season', () {
    test('initial state should be empty', () {
      expect(tvSeasonBloc.state, SeasonEmpty());
      expect(FetchSeasonData(tId, tId).props, [tId, tId]);
    });

    blocTest<TvSeasonBloc, TvSeasonState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetTvSeasonDetail.execute(tId, tId))
            .thenAnswer((_) async => Right(testSeasonTvDetail));
        return tvSeasonBloc;
      },
      act: (bloc) => bloc.add(FetchSeasonData(tId, tId)),
      expect: () => [
        SeasonLoading(),
        SeasonHasData(testSeasonTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvSeasonDetail.execute(tId, tId));
      },
    );

    blocTest<TvSeasonBloc, TvSeasonState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvSeasonDetail.execute(tId, tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeasonBloc;
      },
      act: (bloc) => bloc.add(FetchSeasonData(tId, tId)),
      expect: () => [
        SeasonLoading(),
        SeasonError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeasonDetail.execute(tId, tId));
      },
    );
  });
}
