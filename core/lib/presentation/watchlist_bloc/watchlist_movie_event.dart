part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
}

class GetWatchListMovieData extends WatchlistMovieEvent {
  @override
  List<Object> get props => [];
}
