import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie_detail_model.dart';

void main() {
  final tMovieDetailModelResponse = MovieDetailResponse(
    adult: false,
    backdropPath: '/path.jpg',
    budget: 1,
    genres: [
      GenreModel(id: 77, name: "Action"),
    ],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'en',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: '2002-05-01',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: true,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      // act
      final result = tMovieDetailModelResponse.toJson();
      // assert
      final expectedJsonMap = {
        'adult': false,
        'backdrop_path': '/path.jpg',
        'budget': 1,
        'genres': [
          {
            'id': 77,
            'name': "Action",
          }
        ],
        'homepage': 'homepage',
        'id': 1,
        'imdb_id': 'imdbId',
        'original_language': 'en',
        'original_title': 'originalTitle',
        'overview': 'overview',
        'popularity': 1.0,
        'poster_path': '/path.jpg',
        'release_date': '2002-05-01',
        'revenue': 1,
        'runtime': 1,
        'status': 'status',
        'tagline': 'tagline',
        'title': 'title',
        'video': true,
        'vote_average': 1.0,
        'vote_count': 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
