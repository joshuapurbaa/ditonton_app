part of 'tv_episode_bloc.dart';

abstract class TvEpisodeEvent extends Equatable {
  const TvEpisodeEvent();
}

class FetchEpisodeData extends TvEpisodeEvent {
  final int id;
  final int seasonNumber;
  final int episodeNumber;

  FetchEpisodeData(
    this.id,
    this.seasonNumber,
    this.episodeNumber,
  );
  @override
  List<Object?> get props => [
        id,
        seasonNumber,
        episodeNumber,
      ];
}
