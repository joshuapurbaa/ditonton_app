import 'package:equatable/equatable.dart';
import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  TvModel({
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

  final String? posterPath;
  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String? name;
  final String? originalName;
  final String? overview;
  final List<String>? originCountry;
  final String? originalLanguage;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        posterPath: json['poster_path'],
        backdropPath:
            json['backdrop_path'] == null ? null : json['backdrop_path'],
        firstAirDate: json['first_air_date'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        name: json['name'],
        originalName: json['original_name'],
        overview: json['overview'],
        originCountry: List<String>.from(json['origin_country'].map((x) => x)),
        originalLanguage: json['original_language'],
        popularity: json['popularity'].toDouble(),
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'first_air_date': firstAirDate,
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'id': id,
        'name': name,
        'original_name': originalName,
        'overview': overview,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'popularity': popularity,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  Tv toEntity() {
    return Tv(
      posterPath: this.posterPath,
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originalName: this.originalName,
      overview: this.overview,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      popularity: this.popularity,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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
