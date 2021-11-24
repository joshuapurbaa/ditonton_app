import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/widgets/genre_and_duration.dart';

void main() {
  group('show duration', () {
    test('should return minutes format when runtime less than or equal to 60',
        () {
      // arrange
      final runtime = 50;
      // act
      final formatDuration = showDuration(runtime);
      // assert
      expect(formatDuration, '50m');
    });

    test(
        'should return hours and minuts format when runtime greater than or equal to 60',
        () {
      // arrange
      final runtime = 70;
      // act
      final formatDuration = showDuration(runtime);
      // assert
      expect(formatDuration, '1h 10m');
    });
  });

  group('show genres', () {
    test('should return string genres format when list genres is not empty',
        () {
      // arrange
      List<Genre> genres = [
        Genre(id: 1, name: 'action'),
        Genre(id: 1, name: 'thriller'),
        Genre(id: 1, name: 'sci-fi'),
      ];
      // act
      final result = showGenres(genres);
      // assert
      expect(result, 'action, thriller, sci-fi');
    });

    test('should return empty string genres format when list genres is empty',
        () {
      // arrange
      List<Genre> genres = [];
      // act
      final result = showGenres(genres);
      // assert
      expect(result, '');
    });
  });
}
