import 'package:ditonton/tv_series/data/models/tv_episode_model.dart';
import 'package:equatable/equatable.dart';

class TvEpisodeResponse extends Equatable {
  TvEpisodeResponse({
    required this.episodes,
  });

  final List<TvEpisodeModel> episodes;

  factory TvEpisodeResponse.fromJson(Map<String, dynamic> json) =>
      TvEpisodeResponse(
        episodes: List<TvEpisodeModel>.from(
          json['episodes'].map((x) => TvEpisodeModel.fromJson(x)),
        ),
      );

  @override
  List<Object?> get props => [episodes];
}
