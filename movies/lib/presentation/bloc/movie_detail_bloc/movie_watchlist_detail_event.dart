part of 'movie_watchlist_detail_bloc.dart';

abstract class MovieWatchlistDetailEvent extends Equatable {
  const MovieWatchlistDetailEvent();
}

class AddWatchlist extends MovieWatchlistDetailEvent {
  final MovieDetail movie;

  AddWatchlist(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchlist extends MovieWatchlistDetailEvent {
  final MovieDetail movie;

  RemoveFromWatchlist(this.movie);
  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends MovieWatchlistDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);
  @override
  List<Object> get props => [id];
}
