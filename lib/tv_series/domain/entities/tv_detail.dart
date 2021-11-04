import 'package:equatable/equatable.dart';

import '../entities/tv_create_by.dart';
import '../entities/tv_last_episode.dart';
import '../entities/tv_network.dart';
import '../entities/tv_production_country.dart';
import '../entities/tv_spoken_languages.dart';
import '../entities/tv_season.dart';

import 'package:ditonton/domain/entities/genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.createdBy,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.seasons,
    required this.episodeRunTime,
    required this.homepage,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisode,
    required this.nextEpisode,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.spokenLanguages,
    required this.productionCompanies,
    required this.productionCountries,
    required this.status,
    required this.tagline,
    required this.type,
  });

  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final DateTime? firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<TvSeason> seasons;
  final List<int> episodeRunTime;
  final String homepage;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final TVLastEpisodesToAir lastEpisode;
  final dynamic nextEpisode;
  final List<TvNetwork> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final List<TvSpokenLanguage> spokenLanguages;
  final List<TvNetwork> productionCompanies;
  final List<TvProductionCountry> productionCountries;
  final String status;
  final String tagline;
  final String type;

  @override
  List<Object?> get props => [
        backdropPath,
        createdBy,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        popularity,
        seasons,
        episodeRunTime,
        homepage,
        inProduction,
        languages,
        lastAirDate,
        lastEpisode,
        nextEpisode,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        spokenLanguages,
        productionCompanies,
        productionCountries,
        status,
        tagline,
        type,
      ];
}
