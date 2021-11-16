import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/presentation/bloc/movie_home_bloc/movie_home_bloc.dart';

import '../../../dummy_data_movie/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieHomeBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieHomeBloc(mockGetNowPlayingMovies);
  });

  final tMovies = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(nowPlayingMovieBloc.state, MovieHomeEmpty());
  });

  blocTest<NowPlayingMovieHomeBloc, MovieHomeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovies));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchMovieListHome()),
    expect: () => [
      MovieHomeLoading(),
      MovieHomeHasData(movie: tMovies),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMovieHomeBloc, MovieHomeState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchMovieListHome()),
    expect: () => [
      MovieHomeLoading(),
      MovieHomeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
