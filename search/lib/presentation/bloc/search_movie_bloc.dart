import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;
  SearchMovieBloc(this._searchMovies) : super(SearchMovieEmpty()) {
    on<OnQueryMovieChanged>(
      (event, emit) async {
        final query = event.query;

        if (query.isEmpty) {
          emit(SearchMovieEmpty());
        } else {
          emit(SearchMovieLoading());
          final result = await _searchMovies.execute(query);
          result.fold(
            (failure) => emit(SearchMovieError(failure.message)),
            (data) => emit(SearchMovieHasData(data)),
          );
        }
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  // @override
  // Stream<SearchMovieState> mapEventToState(
  //   SearchMovieEvent event,
  // ) async* {
  //   if (event is OnQueryMovieChanged) {
  //     final query = event.query;

  //     if (query.isEmpty) {
  //       yield SearchMovieEmpty();
  //     } else {
  //       yield SearchMovieLoading();
  //       final result = await _searchMovies.execute(query);

  //       yield* result.fold(
  //         (failure) async* {
  //           yield SearchMovieError(failure.message);
  //         },
  //         (data) async* {
  //           if (data.isEmpty) {
  //             yield SearchMovieNoData('Search not found');
  //           } else {
  //             yield SearchMovieHasData(data);
  //           }
  //         },
  //       );
  //     }
  //   }
  // }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
