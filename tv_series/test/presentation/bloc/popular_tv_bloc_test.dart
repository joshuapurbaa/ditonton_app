import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_home_bloc/popular_tv_home_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVs])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTVs mockGetPopularTVs;

  setUp(() {
    mockGetPopularTVs = MockGetPopularTVs();
    popularTvBloc = PopularTvBloc(mockGetPopularTVs);
  });

  final tTVs = <Tv>[testTv];

  test('initial state should be empty', () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVs));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvData()),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(tTVs),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvData()),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );
}
