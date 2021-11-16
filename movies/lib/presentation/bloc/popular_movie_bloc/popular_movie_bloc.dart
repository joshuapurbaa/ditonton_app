import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieEmpty()) {
    on<PopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(
          PopularMovieError(failure.message),
        ),
        (movieData) => emit(
          PopularMovieHasData(movieData),
        ),
      );
    });
  }
}
