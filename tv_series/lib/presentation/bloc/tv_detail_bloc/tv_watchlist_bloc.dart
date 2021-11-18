import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvDetailWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetTvWatchListStatus getTvWatchListStatus;
  TvDetailWatchlistBloc(
      this.saveWatchlistTv, this.removeWatchlistTv, this.getTvWatchListStatus)
      : super(ReceivedStatus(false, '')) {
    on<AddWatchlist>(_addWatchlist);
    on<RemoveFromWatchlist>(_removeFromWatchlist);
    on<LoadTvWatchlistStatus>(_loadTvWatchlistStatus);
  }

  bool _isAddedToWatchlist = false;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  FutureOr<void> _addWatchlist(
      AddWatchlist event, Emitter<TvWatchlistState> emit) async {
    emit(LoadingStatus());
    final result = await saveWatchlistTv.execute(event.tv);

    result.fold(
      (failure) {
        emit(ErrorStatus(failure.message));
      },
      (successMessage) {
        _isAddedToWatchlist = true;
        emit(ReceivedStatus(true, successMessage));
      },
    );
  }

  FutureOr<void> _removeFromWatchlist(
      RemoveFromWatchlist event, Emitter<TvWatchlistState> emit) async {
    emit(LoadingStatus());
    final result = await removeWatchlistTv.execute(event.tv);

    result.fold(
      (failure) {
        emit(ErrorStatus(failure.message));
      },
      (successMessage) {
        _isAddedToWatchlist = false;
        emit(ReceivedStatus(false, successMessage));
      },
    );
  }

  FutureOr<void> _loadTvWatchlistStatus(
      LoadTvWatchlistStatus event, Emitter<TvWatchlistState> emit) async {
    final statusResult = await getTvWatchListStatus.execute(event.id);
    _isAddedToWatchlist = statusResult;
    emit(ReceivedStatus(_isAddedToWatchlist, ''));
  }
}
