import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/movie_home_bloc/movie_home_bloc.dart';

import '../../../dummy_data_movie/dummy_objects.dart';
import 'top_rated_movie_home_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieHomeBloc topRatedMovieHomeBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieHomeBloc = TopRatedMovieHomeBloc(mockGetTopRatedMovies);
  });

  final tMovies = <Movie>[testMovie];
  test('initial state should be empty', () {
    expect(topRatedMovieHomeBloc.state, MovieHomeEmpty());
  });

  blocTest<TopRatedMovieHomeBloc, MovieHomeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovies));
      return topRatedMovieHomeBloc;
    },
    act: (bloc) => bloc.add(FetchMovieListHome()),
    expect: () => [
      MovieHomeLoading(),
      MovieHomeHasData(movie: tMovies),
    ],
    verify: (_) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
  blocTest<TopRatedMovieHomeBloc, MovieHomeState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMovieHomeBloc;
    },
    act: (bloc) => bloc.add(FetchMovieListHome()),
    expect: () => [
      MovieHomeLoading(),
      MovieHomeError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
