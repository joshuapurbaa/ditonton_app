import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    firstAirDate: "2011-04-17",
    genreIds: [10765, 10759, 18],
    id: 1399,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    originCountry: ["US"],
    originalLanguage: "en",
    popularity: 29.780826,
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_search.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('tv toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
            "genre_ids": [10765, 10759, 18],
            "id": 1399,
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Game of Thrones",
            "overview":
                "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
            "popularity": 29.780826,
            "poster_path": "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
            "first_air_date": "2011-04-17",
            "name": "Game of Thrones",
            "vote_average": 7.91,
            "vote_count": 1172
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
