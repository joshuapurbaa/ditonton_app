import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

final testTv = Tv(
  posterPath: '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
  popularity: 11.520271,
  id: 67419,
  backdropPath: '/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg',
  voteAverage: 1.39,
  overview:
      'The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.',
  firstAirDate: DateTime.parse('2016-08-28'),
  originCountry: ['GB'],
  genreIds: [18],
  originalLanguage: 'en',
  voteCount: 9,
  name: 'Victoria',
  originalName: 'Victoria',
);

final testTvList = [testTv];

final tvNetwork = TvNetwork(
  name: 'name',
  id: 1,
  logoPath: 'logoPath',
  originCountry: 'originCountry',
);

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedBy(
      id: 1,
      creditId: 'creditId',
      name: 'name',
      gender: 1,
      profilePath: 'profilePath',
    )
  ],
  episodeRunTime: [1, 2],
  firstAirDate: DateTime.parse("2014-04-14"),
  genres: [
    Genre(
      id: 1,
      name: 'Action',
    ),
  ],
  homepage: 'homepage',
  id: 1,
  inProduction: true,
  languages: ['aa', 'bb'],
  lastAirDate: DateTime.parse("2014-04-14"),
  lastEpisodeToAir: TVLastEpisodesToAir(
    airDate: DateTime.parse("2014-04-14"),
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 0,
    voteCount: 1,
  ),
  name: 'name',
  nextEpisodeToAir: 12,
  networks: [tvNetwork],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['aa'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.1,
  posterPath: 'posterPath',
  productionCompanies: [tvNetwork],
  productionCountries: [
    TvProductionCountry(
      iso31661: 'iso31661',
      name: 'name',
    )
  ],
  seasons: [
    TvSeason(
      airDate: DateTime.parse("2014-04-14"),
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  spokenLanguages: [
    TvSpokenLanguage(
      englishName: 'englishName',
      iso6391: 'iso6391',
      name: 'name',
    )
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1.1,
  voteCount: 1,
);

final testTvSeries = Tv(
  backdropPath: 'backdropPath',
  firstAirDate: DateTime.parse('2016-08-28'),
  genreIds: [],
  id: 1,
  name: 'name',
  originCountry: [],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesDetail = TvDetail(
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedBy(
      id: 1,
      creditId: 'creditId',
      name: 'name',
      gender: 1,
      profilePath: 'profilePath',
    )
  ],
  episodeRunTime: [1, 2],
  firstAirDate: DateTime.parse("2014-04-14"),
  genres: [
    Genre(
      id: 1,
      name: 'Action',
    ),
  ],
  homepage: 'homepage',
  id: 1,
  inProduction: true,
  languages: ['aa', 'bb'],
  lastAirDate: DateTime.parse("2014-04-14"),
  lastEpisodeToAir: TVLastEpisodesToAir(
    airDate: DateTime.parse("2014-04-14"),
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 0,
    voteCount: 1,
  ),
  name: 'name',
  nextEpisodeToAir: 12,
  networks: [tvNetwork],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['aa'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.1,
  posterPath: 'posterPath',
  productionCompanies: [tvNetwork],
  productionCountries: [
    TvProductionCountry(
      iso31661: 'iso31661',
      name: 'name',
    )
  ],
  seasons: [
    TvSeason(
      airDate: DateTime.parse("2014-04-14"),
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  spokenLanguages: [
    TvSpokenLanguage(
      englishName: 'englishName',
      iso6391: 'iso6391',
      name: 'name',
    )
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1.1,
  voteCount: 1,
);

final testWatchlistTvSeries = Tv.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
