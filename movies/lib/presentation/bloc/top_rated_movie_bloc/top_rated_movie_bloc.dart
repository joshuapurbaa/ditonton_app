import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<TopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(
          TopRatedMovieError(failure.message),
        ),
        (movieData) => emit(
          TopRatedMovieHasData(movieData),
        ),
      );
    });
  }
}
