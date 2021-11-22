import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_episodes_detail_model.dart';
import 'package:tv_series/domain/entities/tv_episodes_detail.dart';

import '../../json_reader.dart';

void main() {
  final tModel = TvEpisodesDetailModel(
    airDate: "2011-04-17",
    name: "Episode 1",
    overview: "overview",
    id: 63056,
    episodeNumber: 1,
    stillPath: "stillPath",
  );

  final tEntities = TvEpisodeDetail(
    airDate: "2011-04-17",
    name: "Episode 1",
    overview: "overview",
    id: 63056,
    episodeNumber: 1,
    stillPath: "stillPath",
  );

  test('should be a subclass of its entity', () async {
    final result = tModel.toEntity();
    expect(result, tEntities);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_episodes_detail.json'));
      // act
      final result = TvEpisodesDetailModel.fromJson(jsonMap);
      // assert
      expect(result, tModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "air_date": "2011-04-17",
        "name": "Episode 1",
        "overview": "overview",
        "id": 63056,
        "episode_number": 1,
        "still_path": "stillPath"
      };
      // act
      final result = tModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
