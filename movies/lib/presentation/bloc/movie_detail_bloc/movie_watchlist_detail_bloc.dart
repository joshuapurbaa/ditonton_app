import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecase/save_movie_watchlist.dart';
import 'package:movies/movies.dart';

part 'movie_watchlist_detail_event.dart';
part 'movie_watchlist_detail_state.dart';

class MovieWatchlistDetailBloc
    extends Bloc<MovieWatchlistDetailEvent, MovieWatchlistDetailState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  MovieWatchlistDetailBloc(
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchListStatus,
  ) : super(ReceivedStatus(false, '')) {
    on<AddWatchlist>(_addWatchlist);
    on<RemoveFromWatchlist>(_removeFromWatchlist);
    on<LoadWatchlistStatus>(_loadWatchlistStatus);
  }

  bool _isAddedToWatchlist = false;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  FutureOr<void> _addWatchlist(
      AddWatchlist event, Emitter<MovieWatchlistDetailState> emit) async {
    emit(LoadingStatus());
    final result = await saveWatchlist.execute(event.movie);

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

  FutureOr<void> _removeFromWatchlist(RemoveFromWatchlist event,
      Emitter<MovieWatchlistDetailState> emit) async {
    emit(LoadingStatus());
    final result = await removeWatchlist.execute(event.movie);

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

  FutureOr<void> _loadWatchlistStatus(LoadWatchlistStatus event,
      Emitter<MovieWatchlistDetailState> emit) async {
    final statusResult = await getWatchListStatus.execute(event.id);
    _isAddedToWatchlist = statusResult;
    emit(ReceivedStatus(_isAddedToWatchlist, ''));
  }
}
