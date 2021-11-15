import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:tv_series/tv_series.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTVs _searchTVs;
  SearchTvBloc(this._searchTVs) : super(SearchTvEmpty()) {
    on<OnQueryTvChanged>(
      (event, emit) async {
        final query = event.query;

        if (query.isEmpty) {
          emit(SearchTvEmpty());
        } else {
          emit(SearchTvLoading());
          final result = await _searchTVs.execute(query);
          result.fold(
            (failure) => emit(SearchTvError(failure.message)),
            (data) => emit(SearchTvHasData(data)),
          );
        }
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
