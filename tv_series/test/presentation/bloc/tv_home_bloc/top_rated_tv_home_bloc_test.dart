import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_home_bloc/tv_home_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_home_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVs])
void main() {
  late TopRatedTvHomeBloc topRatedTvHomeBloc;
  late MockGetTopRatedTVs mockGetTopRatedTVs;

  setUp(() {
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    topRatedTvHomeBloc = TopRatedTvHomeBloc(mockGetTopRatedTVs);
  });

  final tTVs = <Tv>[testTv];

  test('initial state should be empty', () {
    expect(topRatedTvHomeBloc.state, TvHomeEmpty());
  });

  blocTest<TopRatedTvHomeBloc, TvHomeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTVs.execute()).thenAnswer((_) async => Right(tTVs));
      return topRatedTvHomeBloc;
    },
    act: (bloc) => bloc.add(FetchTvListHome()),
    expect: () => [
      TvHomeLoading(),
      TvHomeHasData(tv: tTVs),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );

  blocTest<TopRatedTvHomeBloc, TvHomeState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvHomeBloc;
    },
    act: (bloc) => bloc.add(FetchTvListHome()),
    expect: () => [
      TvHomeLoading(),
      TvHomeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );
}
