import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.posterPath,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.originCountry,
    required this.originalLanguage,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? posterPath;
  String? backdropPath;
  DateTime? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  String? originalName;
  String? overview;
  List<String>? originCountry;
  String? originalLanguage;
  double? popularity;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        posterPath,
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originalName,
        overview,
        originCountry,
        originalLanguage,
        popularity,
        voteAverage,
        voteCount,
      ];
}
