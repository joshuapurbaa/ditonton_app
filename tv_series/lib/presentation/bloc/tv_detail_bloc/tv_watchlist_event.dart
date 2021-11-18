part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();
}

class AddWatchlist extends TvWatchlistEvent {
  final TvDetail tv;

  AddWatchlist(this.tv);
  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchlist extends TvWatchlistEvent {
  final TvDetail tv;

  RemoveFromWatchlist(this.tv);
  @override
  List<Object> get props => [tv];
}

class LoadTvWatchlistStatus extends TvWatchlistEvent {
  final int id;

  LoadTvWatchlistStatus(this.id);
  @override
  List<Object> get props => [id];
}
