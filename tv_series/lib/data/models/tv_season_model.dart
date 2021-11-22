import 'package:tv_series/data/models/tv_episode_model.dart';

import '../../domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  TvSeasonModel({
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
  final List<TvEpisodeModel> episodes;
  final String name;
  final String overview;
  final int id;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        itemId: json["_id"],
        airDate: json["air_date"],
        episodes: List<TvEpisodeModel>.from(
            json["episodes"].map((x) => TvEpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": itemId,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": id,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
  TvSeason toEntity() => TvSeason(
        itemId: this.itemId,
        airDate: this.airDate,
        episodes: this.episodes.map((episodes) => episodes.toEntity()).toList(),
        name: this.name,
        overview: this.overview,
        id: this.id,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
      );

  @override
  List<Object?> get props => [
        itemId,
        airDate,
        episodes,
        name,
        id,
        overview,
        posterPath,
        seasonNumber,
      ];
}
