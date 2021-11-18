import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/tv_series.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListTVs getWatchListTVs;
  WatchlistTvBloc(this.getWatchListTVs) : super(WatchlistTvEmpty()) {
    on<WatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await getWatchListTVs.execute();
      result.fold(
        (failure) => emit(
          WatchlistTvError(failure.message),
        ),
        (data) => emit(
          WatchlistTvHasData(data),
        ),
      );
    });
  }
}
