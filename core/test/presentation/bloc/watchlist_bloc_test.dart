import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/watchlist_bloc/watchlist_movie_bloc.dart';
import 'package:core/presentation/watchlist_bloc/watchlist_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchListTVs])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListTVs mockGetWatchListTVs;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListTVs = MockGetWatchListTVs();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchListTVs);
  });

  group('Watchlist Movies test', () {
    test('initial state should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
      expect(GetWatchListMovieData().props, []);
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovieData()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovieData()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  group('Watchlist TVs test', () {
    test('initial state should be empty', () {
      expect(watchlistTvBloc.state, WatchlistTvEmpty());
      expect(GetWatchListTvData().props, []);
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Available] when data is gotten successfully',
      build: () {
        when(mockGetWatchListTVs.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(GetWatchListTvData()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData([testWatchlistTvSeries]),
      ],
      verify: (bloc) {
        verify(mockGetWatchListTVs.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListTVs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(GetWatchListTvData()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchListTVs.execute());
      },
    );
  });
}
