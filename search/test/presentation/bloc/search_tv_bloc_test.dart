import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:tv_series/tv_series.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTVs])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTVs mockSearchTVs;

  setUp(() {
    mockSearchTVs = MockSearchTVs();
    searchTvBloc = SearchTvBloc(mockSearchTVs);
  });

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchTvEmpty());
  });

  final testTvSeries = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: '2016-08-28',
    genreIds: [],
    id: 1,
    name: 'name',
    originCountry: [],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <Tv>[testTvSeries];
  final tTvQuery = 'game of thrones';

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVs.execute(tTvQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChanged(tTvQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tTvQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVs.execute(tTvQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChanged(tTvQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tTvQuery));
    },
  );
}
