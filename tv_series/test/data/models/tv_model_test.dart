import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  final tTvModel = TvModel(
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    firstAirDate: DateTime.parse("2011-04-17"),
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

  final tTv = Tv(
    posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
    popularity: 29.780826,
    id: 1399,
    backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
    voteAverage: 7.91,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    firstAirDate: DateTime.parse("2011-04-17"),
    originCountry: ["US"],
    genreIds: [10765, 10759, 18],
    originalLanguage: "en",
    voteCount: 1172,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
  );

  test('should be a subclass of tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
