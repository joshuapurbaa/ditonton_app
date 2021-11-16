part of 'movie_home_bloc.dart';

class PopularMovieHomeBloc extends Bloc<FetchMovieListHome, MovieHomeState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieHomeBloc(this.getPopularMovies) : super(MovieHomeEmpty()) {
    on<FetchMovieListHome>((event, emit) async {
      emit(MovieHomeLoading());

      final result = await getPopularMovies.execute();
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
