import '../../domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  TvSeasonModel({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.airDate,
  });

  final int id;
  final String name;
  final int episodeCount;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final DateTime? airDate;

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        id: json['id'],
        name: json['name'],
        episodeCount: json['episode_count'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        airDate:
            json['air_date'] == null ? null : DateTime.parse(json['air_date']),
      );

  TvSeason toEntity() => TvSeason(
        id: this.id,
        name: this.name,
        episodeCount: this.episodeCount,
        overview: this.overview,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
        airDate: this.airDate,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        overview,
        posterPath,
        seasonNumber,
        airDate,
      ];
}
