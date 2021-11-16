part of 'movie_home_bloc.dart';

class TopRatedMovieHomeBloc extends Bloc<FetchMovieListHome, MovieHomeState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieHomeBloc(this.getTopRatedMovies) : super(MovieHomeEmpty()) {
    on<FetchMovieListHome>((event, emit) async {
      emit(MovieHomeLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(MovieHomeError(failure.message));
        },
        (moviesData) {
          emit(MovieHomeHasData(movie: moviesData));
        },
      );
    });
  }
}
