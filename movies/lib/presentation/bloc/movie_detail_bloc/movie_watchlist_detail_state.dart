part of 'movie_watchlist_detail_bloc.dart';

abstract class MovieWatchlistDetailState extends Equatable {
  const MovieWatchlistDetailState();

  @override
  List<Object> get props => [];
}

class LoadingStatus extends MovieWatchlistDetailState {}

class ErrorStatus extends MovieWatchlistDetailState {
  final String message;
  ErrorStatus(this.message);
  @override
  List<Object> get props => [message];
}

class ReceivedStatus extends MovieWatchlistDetailState {
  final bool status;
  final String message;

  ReceivedStatus(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}
