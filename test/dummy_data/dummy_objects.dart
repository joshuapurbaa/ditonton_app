import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv_crew.dart';
import 'package:tv_series/domain/entities/tv_episodes_detail.dart';
import 'package:tv_series/domain/entities/tv_guest_stars.dart';
import 'package:tv_series/domain/entities/tv_season_detail.dart';
import 'package:tv_series/tv_series.dart';

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

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
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

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testMovieList = [testMovie];

final testTv = Tv(
  posterPath: '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
  popularity: 11.520271,
  id: 67419,
  backdropPath: '/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg',
  voteAverage: 1.39,
  overview:
      'The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.',
  firstAirDate: '2016-08-28',
  originCountry: ['GB'],
  genreIds: [18],
  originalLanguage: 'en',
  voteCount: 9,
  name: 'Victoria',
  originalName: 'Victoria',
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  episodeRunTime: [1, 2],
  firstAirDate: '2014-04-14',
  genres: [
    Genre(
      id: 1,
      name: 'Action',
    ),
  ],
  id: 1,
  homepage: 'homepage',
  inProduction: true,
  lastAirDate: '2014-04-14',
  lastEpisodeToAir: TvEpisodeDetail(
    airDate: '2014-04-14',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  ),
  name: 'name',
  nextEpisodeToAir: TvEpisodeDetail(
    airDate: '2014-04-14',
    episodeNumber: 2,
    id: 2,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  ),
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.1,
  posterPath: 'posterPath',
  seasons: [
    TvSeasonDetail(
      airDate: '2014-04-14',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1.1,
  voteCount: 1,
);

final testTvSeries = Tv(
  backdropPath: 'backdropPath',
  firstAirDate: '2016-08-28',
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
  episodeRunTime: [1, 2],
  firstAirDate: '2014-04-14',
  genres: [
    Genre(
      id: 1,
      name: 'Action',
    ),
  ],
  id: 1,
  homepage: 'homePage',
  inProduction: true,
  lastAirDate: '2014-04-20',
  lastEpisodeToAir: TvEpisodeDetail(
    airDate: '2014-04-14',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  ),
  name: 'name',
  nextEpisodeToAir: TvEpisodeDetail(
    airDate: '2015-04-14',
    episodeNumber: 2,
    id: 2,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  ),
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.1,
  posterPath: 'posterPath',
  seasons: [
    TvSeasonDetail(
      airDate: '2014-04-14',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1.1,
  voteCount: 1,
);

final testTvEpisodes = TvEpisode(
  airDate: '2014-04-14',
  crew: [],
  episodeNumber: 1,
  guestStars: [],
  name: 'name',
  overview: 'overview',
  id: 1,
  productionCode: 'productionCode',
  seasonNumber: 1,
  stillPath: 'stillPath',
);

final testEpisodeTvDetail = TvEpisode(
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

final testSeasonTvDetail = TvSeason(
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

final testTvSeasonWithImage = TvSeason(
  itemId: '5256c89f19c2956ff6046d47',
  airDate: '2011-04-17',
  episodes: [
    TvEpisode(
      airDate: '2011-04-17',
      crew: [
        Crew(
          id: 44797,
          creditId: '5256c8a219c2956ff6046e77',
          name: 'Timothy Van Patten',
          department: 'Directing',
          job: 'Director',
          profilePath: '/MzSOFrd99HRdr6pkSRSctk3kBR.jpg',
        ),
      ],
      episodeNumber: 1,
      guestStars: [
        GuestStars(
          id: 117642,
          name: 'Jason Momoa',
          creditId: '5256c8a219c2956ff6046f40',
          character: 'Khal Drogo',
          order: 0,
          profilePath: '/6dEFBpZH8C8OijsynkSajQT99Pb.jpg',
        ),
      ],
      name: 'Lord Snow',
      overview:
          "Lord Stark and his daughters arrive at King's Landing to discover the intrigues of the king's realm.",
      id: 63058,
      productionCode: '103',
      seasonNumber: 1,
      stillPath: '/4vCYVtIhiYSUry1lviA7CKPUB5Z.jpg',
    ),
  ],
  name: 'Season 1',
  overview:
      "Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.",
  id: 3624,
  posterPath: '/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg',
  seasonNumber: 1,
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
  'poster_path': 'posterPath',
  'name': 'name',
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testTvCache = TvTable(
  id: 1399,
  name: 'Game of Thrones',
  posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
);

final testTvFromCache = Tv.watchlist(
  id: 1399,
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  name: 'Game of Thrones',
);

final testTvCacheMap = {
  'id': 1399,
  'overview':
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  'poster_path': '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  'name': 'Game of Thrones',
};

class FakeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListTile(
      key: Key('fake_tile'),
      onTap: () {
        Navigator.pushNamed(context, '/second');
      },
      title: Text('This is Fake'),
      leading: Icon(Icons.check),
    ));
  }
}

class FakeTargetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListTile(
      key: Key('fake_second_tile'),
      onTap: () {
        Navigator.pop(context);
      },
      title: Text('This is Fake'),
      leading: Icon(Icons.check),
    ));
  }
}
