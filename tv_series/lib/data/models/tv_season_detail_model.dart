import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_season_detail.dart';

class TvSeasonDetailModel extends Equatable {
  TvSeasonDetailModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? airDate;
  final int episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailModel(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
      airDate: this.airDate,
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
