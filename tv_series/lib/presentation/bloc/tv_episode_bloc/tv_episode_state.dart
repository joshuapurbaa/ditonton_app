part of 'tv_episode_bloc.dart';

abstract class TvEpisodeState extends Equatable {
  const TvEpisodeState();

  @override
  List<Object> get props => [];
}

class EpisodeEmpty extends TvEpisodeState {}

class EpisodeLoading extends TvEpisodeState {}

class EpisodeError extends TvEpisodeState {
  final String message;

  EpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

class EpisodeHasData extends TvEpisodeState {
  final TvEpisode result;

  EpisodeHasData(this.result);
  @override
  List<Object> get props => [result];
}
