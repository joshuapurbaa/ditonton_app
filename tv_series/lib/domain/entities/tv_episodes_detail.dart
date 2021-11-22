import 'package:equatable/equatable.dart';

class TvEpisodeDetail extends Equatable {
  TvEpisodeDetail({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
  });

  final String? airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        stillPath,
      ];
}
