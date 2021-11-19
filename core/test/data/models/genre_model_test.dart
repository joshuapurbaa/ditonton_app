import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: "name");

  final tGenre = Genre(id: 1, name: "name");

  test('should be a subclass of its entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  group('genre models', () {
    test('should return genre model when fromJson() function called', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/genre.json'));
      // act
      final result = GenreModel.fromJson(jsonMap);
      // assert
      expect(result, tGenreModel);
    });
    test('should return genre map when toJson() function called', () async {
      // arrange
      final expectedJsonMap = {"id": 1, "name": "name"};
      // act
      final result = tGenreModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
