part of 'tv_season_bloc.dart';

abstract class TvSeasonEvent extends Equatable {
  const TvSeasonEvent();
}

class FetchSeasonData extends TvSeasonEvent {
  final int id;
  final int seasonNumber;

  FetchSeasonData(this.id, this.seasonNumber);
  @override
  List<Object?> get props => [id, seasonNumber];
}
