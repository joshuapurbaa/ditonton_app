import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/tv_series/data/models/tv_detail_model.dart';
import 'package:ditonton/tv_series/data/models/tv_episode_model.dart';
import 'package:ditonton/tv_series/data/models/tv_episode_response.dart';
import 'package:ditonton/tv_series/data/models/tv_model.dart';
import 'package:ditonton/tv_series/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getTvAiringToday();
  Future<List<TvModel>> getPopularTVs();
  Future<List<TvModel>> getTopRatedTVs();
  Future<TvDetailModel> getDetailTVs(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvEpisodeModel>> getTvSeasonEpisodes(int id, int seasonNumber);
  Future<List<TvModel>> searchTVs(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvDetailModel> getDetailTVs(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTVs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTVs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvAiringToday() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvEpisodeModel>> getTvSeasonEpisodes(
      int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return TvEpisodeResponse.fromJson(json.decode(response.body)).episodes;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTVs(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
