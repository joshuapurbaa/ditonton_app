import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_guest_star_model.dart';
import 'package:tv_series/domain/entities/tv_guest_stars.dart';

import '../../json_reader.dart';

void main() {
  final tGuestStarModel = GuestStarModel(
    id: 1,
    name: 'name',
    creditId: 'creditId',
    character: 'character',
    order: 1,
    profilePath: 'profilePath',
  );

  final tGuesStar = GuestStars(
    id: 1,
    name: 'name',
    creditId: 'creditId',
    character: 'character',
    order: 1,
    profilePath: 'profilePath',
  );

  test('should be a subclass of Crew entity', () async {
    final result = tGuestStarModel.toEntity();
    expect(result, tGuesStar);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_guest_star.json'));
      // act
      final result = GuestStarModel.fromJson(jsonMap);
      // assert
      expect(result, tGuestStarModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'id': 1,
        'name': 'name',
        'credit_id': 'creditId',
        'character': 'character',
        'order': 1,
        'profile_path': 'profilePath',
      };
      // act
      final result = tGuestStarModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
