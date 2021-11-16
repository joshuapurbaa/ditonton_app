part of 'movie_home_bloc.dart';

class NowPlayingMovieHomeBloc extends Bloc<FetchMovieListHome, MovieHomeState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieHomeBloc(this.getNowPlayingMovies) : super(MovieHomeEmpty()) {
    on<FetchMovieListHome>((event, emit) async {
      emit(MovieHomeLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(
          MovieHomeError(failure.message),
        ),
        (movieData) => emit(
          MovieHomeHasData(movie: movieData),
        ),
      );
    });
  }
}
