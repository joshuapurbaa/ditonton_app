import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/tv_series/data/models/tv_table_model.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:ditonton/tv_series/domain/entities/tv_create_by.dart';
import 'package:ditonton/tv_series/domain/entities/tv_detail.dart';
import 'package:ditonton/tv_series/domain/entities/tv_last_episode.dart';
import 'package:ditonton/tv_series/domain/entities/tv_network.dart';
import 'package:ditonton/tv_series/domain/entities/tv_production_country.dart';
import 'package:ditonton/tv_series/domain/entities/tv_season.dart';
import 'package:ditonton/tv_series/domain/entities/tv_spoken_languages.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

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

final testMovieList = [testMovie];
final testTvList = [testTv];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [
    Genre(id: 1, name: 'Action'),
  ],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
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

final tvNetwork = TvNetwork(
  name: 'name',
  id: 1,
  logoPath: 'logoPath',
  originCountry: 'originCountry',
);

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

// test tv series - presentation

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
