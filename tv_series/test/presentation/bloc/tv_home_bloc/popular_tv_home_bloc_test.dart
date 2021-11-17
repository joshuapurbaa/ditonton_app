import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_home_bloc/tv_home_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_home_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVs])
void main() {
  late PopularTvHomeBloc popularTvHomeBloc;
  late MockGetPopularTVs mockGetPopularTVs;

  setUp(() {
    mockGetPopularTVs = MockGetPopularTVs();
    popularTvHomeBloc = PopularTvHomeBloc(mockGetPopularTVs);
  });

  final tTVs = <Tv>[testTv];

  test('initial state should be empty', () {
    expect(popularTvHomeBloc.state, TvHomeEmpty());
  });

  blocTest<PopularTvHomeBloc, TvHomeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVs));
      return popularTvHomeBloc;
    },
    act: (bloc) => bloc.add(FetchTvListHome()),
    expect: () => [
      TvHomeLoading(),
      TvHomeHasData(tv: tTVs),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<PopularTvHomeBloc, TvHomeState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvHomeBloc;
    },
    act: (bloc) => bloc.add(FetchTvListHome()),
    expect: () => [
      TvHomeLoading(),
      TvHomeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );
}
