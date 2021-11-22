import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_crew_model.dart';
import 'package:tv_series/data/models/tv_guest_star_model.dart';
import 'package:tv_series/domain/entities/tv_crew.dart';
import 'package:tv_series/domain/entities/tv_guest_stars.dart';
import 'package:tv_series/tv_series.dart';

import '../../json_reader.dart';

void main() {
  final tTvEpisodeModel = TvEpisodeModel(
    airDate: "2011-04-17",
    crew: [
      CrewModel(
        id: 44797,
        creditId: "5256c8a219c2956ff6046e77",
        name: "Tim Van Patten",
        department: "Directing",
        job: "Director",
        profilePath: "/6b7l9YbkDHDOzOKUFNqBVaPjcgm.jpg",
      )
    ],
    episodeNumber: 1,
    guestStars: [
      GuestStarModel(
        id: 117642,
        name: "Jason Momoa",
        creditId: "5256c8a219c2956ff6046f40",
        character: "Khal Drogo",
        order: 0,
        profilePath: "/PSK6GmsVwdhqz9cd1lwzC6a7EA.jpg",
      ),
    ],
    name: "Winter Is Coming",
    overview:
        "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
    id: 63056,
    productionCode: "101",
    seasonNumber: 1,
    stillPath: "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg",
  );

  final tTvEpisode = TvEpisode(
    airDate: "2011-04-17",
    crew: [
      Crew(
        id: 44797,
        creditId: "5256c8a219c2956ff6046e77",
        name: "Tim Van Patten",
        department: "Directing",
        job: "Director",
        profilePath: "/6b7l9YbkDHDOzOKUFNqBVaPjcgm.jpg",
      )
    ],
    episodeNumber: 1,
    guestStars: [
      GuestStars(
        id: 117642,
        name: "Jason Momoa",
        creditId: "5256c8a219c2956ff6046f40",
        character: "Khal Drogo",
        order: 0,
        profilePath: "/PSK6GmsVwdhqz9cd1lwzC6a7EA.jpg",
      ),
    ],
    name: "Winter Is Coming",
    overview:
        "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
    id: 63056,
    productionCode: "101",
    seasonNumber: 1,
    stillPath: "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg",
  );

  test('should be a subclass of the entity', () async {
    final result = tTvEpisodeModel.toEntity();
    expect(result, tTvEpisode);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_episode.json'));
      // act
      final result = TvEpisodeModel.fromJson(jsonMap);
      // assert
      expect(result, tTvEpisodeModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "air_date": "2011-04-17",
        "crew": [
          {
            "id": 44797,
            "credit_id": "5256c8a219c2956ff6046e77",
            "name": "Tim Van Patten",
            "department": "Directing",
            "job": "Director",
            "profile_path": "/6b7l9YbkDHDOzOKUFNqBVaPjcgm.jpg"
          }
        ],
        "episode_number": 1,
        "guest_stars": [
          {
            "id": 117642,
            "name": "Jason Momoa",
            "credit_id": "5256c8a219c2956ff6046f40",
            "character": "Khal Drogo",
            "order": 0,
            "profile_path": "/PSK6GmsVwdhqz9cd1lwzC6a7EA.jpg"
          }
        ],
        "name": "Winter Is Coming",
        "overview":
            "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
        "id": 63056,
        "production_code": "101",
        "season_number": 1,
        "still_path": "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg"
      };
      // act
      final result = tTvEpisodeModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
