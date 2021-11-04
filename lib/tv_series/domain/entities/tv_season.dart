import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  TvSeason({
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
