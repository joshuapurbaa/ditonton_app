import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/tv_crew_model.dart';
import 'package:tv_series/data/models/tv_guest_star_model.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';

class TvEpisodeModel extends Equatable {
  TvEpisodeModel({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
  });

  final String airDate;
  final List<CrewModel> crew;
  final int episodeNumber;
  final List<GuestStarModel> guestStars;
  final String name;
  final String overview;
  final int id;
  final String? productionCode;
  final int seasonNumber;
  final String? stillPath;

  factory TvEpisodeModel.fromJson(Map<String, dynamic> json) => TvEpisodeModel(
        airDate: json["air_date"],
        crew: List<CrewModel>.from(
            json["crew"].map((x) => CrewModel.fromJson(x))),
        episodeNumber: json['episode_number'],
        guestStars: List<GuestStarModel>.from(
            json["guest_stars"].map((x) => GuestStarModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "episode_number": episodeNumber,
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": id,
        "season_number": seasonNumber,
        "production_code": productionCode,
        "still_path": stillPath,
      };

  TvEpisode toEntity() {
    return TvEpisode(
      airDate: this.airDate,
      crew: this.crew.map((e) => e.toEntity()).toList(),
      episodeNumber: this.episodeNumber,
      guestStars: this.guestStars.map((e) => e.toEntity()).toList(),
      name: this.name,
      overview: this.overview,
      id: this.id,
      seasonNumber: this.seasonNumber,
      productionCode: this.productionCode,
      stillPath: this.stillPath,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        crew,
        episodeNumber,
        guestStars,
        name,
        overview,
        id,
        seasonNumber,
        productionCode,
        stillPath,
      ];
}
