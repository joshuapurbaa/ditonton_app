import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_detail_model.dart';
import 'package:tv_series/data/models/tv_episodes_detail_model.dart';
import 'package:tv_series/data/models/tv_season_detail_model.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/entities/tv_episodes_detail.dart';
import 'package:tv_series/domain/entities/tv_season_detail.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvDetailModel(
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2],
    firstAirDate: '2014-04-14',
    genres: [
      GenreModel(
        id: 1,
        name: 'Action',
      ),
    ],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    lastAirDate: '2014-04-20',
    lastEpisodeToAir: TvEpisodesDetailModel(
      airDate: '2014-04-14',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      stillPath: 'stillPath',
    ),
    name: 'name',
    nextEpisodeToAir: TvEpisodesDetailModel(
      airDate: '2014-04-16',
      episodeNumber: 2,
      id: 2,
      name: 'name',
      overview: 'overview',
      stillPath: 'stillPath',
    ),
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.1,
    posterPath: 'posterPath',
    seasons: [
      TvSeasonDetailModel(
        airDate: '2014-04-19',
        episodeCount: 3,
        id: 2,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = TvDetail(
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2],
    firstAirDate: '2014-04-14',
    genres: [
      Genre(
        id: 1,
        name: 'Action',
      ),
    ],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    lastAirDate: '2014-04-20',
    lastEpisodeToAir: TvEpisodeDetail(
      airDate: '2014-04-14',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      stillPath: 'stillPath',
    ),
    name: 'name',
    nextEpisodeToAir: TvEpisodeDetail(
      airDate: '2014-04-16',
      episodeNumber: 2,
      id: 2,
      name: 'name',
      overview: 'overview',
      stillPath: 'stillPath',
    ),
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.1,
    posterPath: 'posterPath',
    seasons: [
      TvSeasonDetail(
        airDate: '2014-04-19',
        episodeCount: 3,
        id: 2,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_detail.json'));
      // act
      final result = TvDetailModel.fromJson(jsonMap);
      // assert
      expect(result, tTvModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "backdrop_path": "backdropPath",
        "episode_run_time": [1, 2],
        "first_air_date": "2014-04-14",
        "genres": [
          {
            "id": 1,
            "name": "Action",
          }
        ],
        "homepage": "homepage",
        "id": 1,
        "in_production": true,
        "last_air_date": "2014-04-20",
        "last_episode_to_air": {
          "air_date": "2014-04-14",
          "episode_number": 1,
          "id": 1,
          "name": "name",
          "overview": "overview",
          "still_path": "stillPath"
        },
        "name": "name",
        "next_episode_to_air": {
          "air_date": "2014-04-16",
          "episode_number": 2,
          "id": 2,
          "name": "name",
          "overview": "overview",
          "still_path": "stillPath"
        },
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "original_language": "originalLanguage",
        "original_name": "originalName",
        "overview": "overview",
        "popularity": 1.1,
        "poster_path": "posterPath",
        "seasons": [
          {
            "air_date": "2014-04-19",
            "episode_count": 3,
            "id": 2,
            "name": "name",
            "overview": "overview",
            "poster_path": "posterPath",
            "season_number": 1
          }
        ],
        "status": "status",
        "tagline": "tagline",
        "type": "type",
        "vote_average": 1.0,
        "vote_count": 1
      };
      // act
      final result = tTvModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
