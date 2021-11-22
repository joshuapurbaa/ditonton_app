import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';

class TvSeason extends Equatable {
  TvSeason({
    required this.itemId,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String itemId;
  final String? airDate;
  final List<TvEpisode> episodes;
  final String name;
  final String overview;
  final int id;
  final String? posterPath;
  final int seasonNumber;
  @override
  List<Object?> get props => [
        itemId,
        airDate,
        episodes,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
      ];
}
