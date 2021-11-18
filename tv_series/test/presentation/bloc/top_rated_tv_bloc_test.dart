import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVs])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTVs mockGetTopRatedTVs;

  setUp(() {
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTVs);
  });

  final tTVs = <Tv>[testTv];

  test('initial state should be empty', () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTVs.execute()).thenAnswer((_) async => Right(tTVs));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvData()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(tTVs),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvData()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );
}
