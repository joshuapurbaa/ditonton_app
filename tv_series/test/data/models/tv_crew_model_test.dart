import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_crew_model.dart';
import 'package:tv_series/domain/entities/tv_crew.dart';

import '../../json_reader.dart';

void main() {
  final tCrewModel = CrewModel(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    department: 'department',
    job: 'job',
    profilePath: 'profilePath',
  );

  final tCrew = Crew(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    department: 'department',
    job: 'job',
    profilePath: 'profilePath',
  );

  test('should be a subclass of Crew entity', () async {
    final result = tCrewModel.toEntity();
    expect(result, tCrew);
  });

  group('check fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('dummy_data/tv_crew.json'));
      // act
      final result = CrewModel.fromJson(jsonMap);
      // assert
      expect(result, tCrewModel);
    });
  });

  group('check toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'id': 1,
        'credit_id': 'creditId',
        'name': 'name',
        'department': 'department',
        'job': 'job',
        'profile_path': 'profilePath',
      };
      // act
      final result = tCrewModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
