import 'package:core/tv_series/data/models/tv_episode_model.dart';
import 'package:core/tv_series/domain/entities/tv_episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvEpisodeModel = TvEpisodeModel(
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

  final tTvEpisode = TvEpisode(
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

  test('should be a subclass of tv series episode entity', () async {
    final result = tTvEpisodeModel.toEntity();
    expect(result, tTvEpisode);
  });
}
