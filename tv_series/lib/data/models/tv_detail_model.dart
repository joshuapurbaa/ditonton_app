import 'package:core/data/models/genre_model.dart';

import '../../domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/tv_createdby_model.dart';
import '../../data/models/tv_last_episode_model.dart';
import '../../data/models/tv_network_model.dart';
import '../../data/models/tv_production_country_model.dart';
import '../../data/models/tv_season_model.dart';
import '../../data/models/tv_spoken_language_model.dart';

class TvDetailModel extends Equatable {
  TvDetailModel({
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
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
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
  final List<CreatedByModel>? createdBy;
  final List<GenreModel> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final DateTime? firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<TvSeasonModel> seasons;
  final List<int> episodeRunTime;
  final String homepage;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final TVLastEpisodesToAirModel lastEpisodeToAir;
  final dynamic nextEpisodeToAir;
  final List<TvNetworkModel> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final List<TvSpokenLanguageModel> spokenLanguages;
  final List<TvNetworkModel> productionCompanies;
  final List<TvProductionCountryModel> productionCountries;
  final String status;
  final String tagline;
  final String type;

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        backdropPath: json['backdrop_path'],
        createdBy: json['created_by'] == null
            ? null
            : List<CreatedByModel>.from(
                json['created_by'].map((x) => CreatedByModel.fromJson(x))),
        genres: List<GenreModel>.from(
            json['genres'].map((x) => GenreModel.fromJson(x))),
        id: json['id'],
        originalName: json['original_name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        firstAirDate: json['first_air_date'] == null
            ? null
            : DateTime.tryParse(json['first_air_date']),
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        popularity: json["popularity"].toDouble(),
        seasons: List<TvSeasonModel>.from(
            json['seasons'].map((x) => TvSeasonModel.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        homepage: json["homepage"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir:
            TVLastEpisodesToAirModel.fromJson(json['last_episode_to_air']),
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: List<TvNetworkModel>.from(
            json["networks"].map((x) => TvNetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        spokenLanguages: List<TvSpokenLanguageModel>.from(
            json["spoken_languages"]
                .map((x) => TvSpokenLanguageModel.fromJson(x))),
        productionCompanies: List<TvNetworkModel>.from(
            json["production_companies"]
                .map((x) => TvNetworkModel.fromJson(x))),
        productionCountries: List<TvProductionCountryModel>.from(
            json["production_countries"]
                .map((x) => TvProductionCountryModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
      );

  TvDetail toEntity() => TvDetail(
        backdropPath: this.backdropPath,
        createdBy: this.createdBy?.map((x) => x.toEntity()).toList(),
        genres: this.genres.map((x) => x.toEntity()).toList(),
        id: this.id,
        originalName: this.originalName,
        overview: this.overview,
        posterPath: this.posterPath,
        firstAirDate: this.firstAirDate,
        name: this.name,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
        popularity: this.popularity,
        seasons: this.seasons.map((x) => x.toEntity()).toList(),
        episodeRunTime: this.episodeRunTime,
        homepage: this.homepage,
        inProduction: this.inProduction,
        languages: this.languages,
        lastAirDate: this.lastAirDate,
        lastEpisodeToAir: this.lastEpisodeToAir.toEntity(),
        nextEpisodeToAir: this.nextEpisodeToAir,
        networks: this.networks.map((x) => x.toEntity()).toList(),
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originCountry: this.originCountry,
        originalLanguage: this.originalLanguage,
        spokenLanguages: this
            .spokenLanguages
            .map((spokenLanguage) => spokenLanguage.toEntity())
            .toList(),
        productionCompanies:
            this.productionCompanies.map((x) => x.toEntity()).toList(),
        productionCountries:
            this.productionCountries.map((x) => x.toEntity()).toList(),
        status: this.status,
        tagline: this.tagline,
        type: this.type,
      );

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
        lastEpisodeToAir,
        nextEpisodeToAir,
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
