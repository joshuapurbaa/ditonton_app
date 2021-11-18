part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class LoadingStatus extends TvWatchlistState {}

class ErrorStatus extends TvWatchlistState {
  final String message;
  ErrorStatus(this.message);
  @override
  List<Object> get props => [message];
}

class ReceivedStatus extends TvWatchlistState {
  final bool status;
  final String message;

  ReceivedStatus(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}
