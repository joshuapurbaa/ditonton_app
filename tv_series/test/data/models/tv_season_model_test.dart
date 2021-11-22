import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_crew_model.dart';
import 'package:tv_series/data/models/tv_episode_model.dart';
import 'package:tv_series/data/models/tv_guest_star_model.dart';
import 'package:tv_series/data/models/tv_season_model.dart';
import 'package:tv_series/domain/entities/tv_crew.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/domain/entities/tv_guest_stars.dart';
import 'package:tv_series/domain/entities/tv_season.dart';

import '../../json_reader.dart';

void main() {
  final tvSeasonModel = TvSeasonModel(
    itemId: 'itemId',
    airDate: '2011-04-17',
    episodes: [
      TvEpisodeModel(
        airDate: '2011-04-17',
        crew: [
          CrewModel(
            id: 1,
            creditId: 'creditId',
            name: 'name',
            department: 'department',
            job: 'job',
            profilePath: 'profilePath',
          ),
        ],
        episodeNumber: 1,
        guestStars: [
          GuestStarModel(
            id: 1,
            name: 'name',
            creditId: 'creditId',
            character: 'character',
            order: 0,
            profilePath: 'profilePath',
          ),
        ],
        name: 'name',
        overview: "overview",
        id: 1,
        productionCode: '123',
        seasonNumber: 1,
        stillPath: 'stillPath',
      ),
    ],
    name: 'name',
    overview: 'overview',
    id: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTvSeason = TvSeason(
    itemId: 'itemId',
    airDate: '2011-04-17',
    episodes: [
      TvEpisode(
        airDate: '2011-04-17',
        crew: [
          Crew(
            id: 1,
            creditId: 'creditId',
            name: 'name',
            department: 'department',
            job: 'job',
            profilePath: 'profilePath',
          ),
        ],
        episodeNumber: 1,
        guestStars: [
          GuestStars(
            id: 1,
            name: 'name',
            creditId: 'creditId',
            character: 'character',
            order: 0,
            profilePath: 'profilePath',
          ),
        ],
        name: 'name',
        overview: "overview",
        id: 1,
        productionCode: '123',
        seasonNumber: 1,
        stillPath: 'stillPath',
      ),
    ],
    name: 'name',
    overview: 'overview',
    id: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be a subclass of TV entity', () async {
    final result = tvSeasonModel.toEntity();
    expect(result, tTvSeason);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_season.json'));
      // act
      final result = TvSeasonModel.fromJson(jsonMap);
      // assert
      expect(result, tvSeasonModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        '_id': 'itemId',
        'air_date': '2011-04-17',
        'episodes': [
          {
            'air_date': '2011-04-17',
            'crew': [
              {
                'id': 1,
                'credit_id': 'creditId',
                'name': 'name',
                'department': 'department',
                'job': 'job',
                'profile_path': 'profilePath',
              }
            ],
            'episode_number': 1,
            'guest_stars': [
              {
                'id': 1,
                'name': 'name',
                'credit_id': 'creditId',
                'character': 'character',
                'order': 0,
                'profile_path': 'profilePath',
              }
            ],
            'name': 'name',
            'overview': "overview",
            'id': 1,
            'production_code': '123',
            'season_number': 1,
            'still_path': 'stillPath',
          }
        ],
        'name': 'name',
        'overview': 'overview',
        'id': 1,
        'poster_path': 'posterPath',
        'season_number': 1,
      };
      // act
      final result = tvSeasonModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
