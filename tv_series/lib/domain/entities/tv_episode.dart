import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_crew.dart';
import 'package:tv_series/domain/entities/tv_guest_stars.dart';

class TvEpisode extends Equatable {
  TvEpisode({
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
  final List<Crew> crew;
  final int episodeNumber;
  final List<GuestStars> guestStars;
  final String name;
  final String overview;
  final int id;
  final String? productionCode;
  final int seasonNumber;
  final String? stillPath;
  @override
  List<Object?> get props => [
        airDate,
        crew,
        episodeNumber,
        guestStars,
        name,
        overview,
        id,
        productionCode,
        seasonNumber,
        stillPath,
      ];
}
