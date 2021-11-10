import 'dart:convert';

import 'package:core/tv_series/data/models/tv_episode_model.dart';
import 'package:core/tv_series/data/models/tv_episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tvEpisodeModel = TvEpisodeModel(
    airDate: DateTime.parse("2011-04-17"),
    episodeNumber: 1,
    id: 63057,
    name: "The Kingsroad",
    overview:
        "While Bran recovers from his fall, Ned takes only his daughters to Kings Landing. Jon Snow goes with his uncle Benjen to The Wall. Tyrion joins them.",
    productionCode: "102",
    seasonNumber: 1,
    stillPath: "/icjOgl5F9DhysOEo6Six2Qfwcu2.jpg",
    voteAverage: 7.5,
    voteCount: 118,
  );
  final tTvResponseModel = TvEpisodeResponse(
    episodes: <TvEpisodeModel>[tvEpisodeModel],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_episode.json'));
      // act
      final result = TvEpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });
}
