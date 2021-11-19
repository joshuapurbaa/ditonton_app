import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/presentation/bloc/movie_home_bloc/movie_home_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movie_home_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieHomeBloc popularMovieHomeBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieHomeBloc = PopularMovieHomeBloc(mockGetPopularMovies);
  });

  final tMovies = <Movie>[testMovie];
  test('initial state should be empty', () {
    expect(popularMovieHomeBloc.state, MovieHomeEmpty());
  });
  blocTest<PopularMovieHomeBloc, MovieHomeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovies));
      return popularMovieHomeBloc;
    },
    act: (bloc) => bloc.add(FetchMovieListHome()),
    expect: () => [
      MovieHomeLoading(),
      MovieHomeHasData(movie: tMovies),
    ],
    verify: (_) {
      verify(mockGetPopularMovies.execute());
    },
  );
  blocTest<PopularMovieHomeBloc, MovieHomeState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMovieHomeBloc;
    },
    act: (bloc) => bloc.add(FetchMovieListHome()),
    expect: () => [
      MovieHomeLoading(),
      MovieHomeError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
