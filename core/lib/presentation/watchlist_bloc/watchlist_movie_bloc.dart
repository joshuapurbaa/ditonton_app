import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistEmpty()) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(WatchlistLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(
          WatchlistError(failure.message),
        ),
        (data) => emit(
          WatchlistHasData(data),
        ),
      );
    });
  }
}
