import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_season_detail_model.dart';
import 'package:tv_series/domain/entities/tv_season_detail.dart';

import '../../json_reader.dart';

void main() {
  final seasonDetailModel = TvSeasonDetailModel(
    airDate: '2000-01-01',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final seasonDetail = TvSeasonDetail(
    airDate: '2000-01-01',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be a subclass of the entity', () async {
    final result = seasonDetailModel.toEntity();
    expect(result, seasonDetail);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_season_detail.json'));
      // act
      final result = TvSeasonDetailModel.fromJson(jsonMap);
      // assert
      expect(result, seasonDetailModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "air_date": "2000-01-01",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1
      };
      // act
      final result = seasonDetailModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
