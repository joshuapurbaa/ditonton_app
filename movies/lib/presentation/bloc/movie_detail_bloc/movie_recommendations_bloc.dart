import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;
  MovieRecommendationsBloc(this.getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<FetchMovieRecommendations>((event, emit) async {
      emit(MovieRecommendationLoading());

      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) => emit(
          MovieRecommendationError(failure.message),
        ),
        (data) => emit(
          MovieRecommendationHasData(data),
        ),
      );
    });
  }
}
