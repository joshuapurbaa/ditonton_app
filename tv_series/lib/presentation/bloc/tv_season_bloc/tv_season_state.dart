part of 'tv_season_bloc.dart';

abstract class TvSeasonState extends Equatable {
  const TvSeasonState();

  @override
  List<Object> get props => [];
}

class SeasonEmpty extends TvSeasonState {}

class SeasonLoading extends TvSeasonState {}

class SeasonError extends TvSeasonState {
  final String message;

  SeasonError(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonHasData extends TvSeasonState {
  final TvSeason result;

  SeasonHasData(this.result);

  @override
  List<Object> get props => [result];
}
