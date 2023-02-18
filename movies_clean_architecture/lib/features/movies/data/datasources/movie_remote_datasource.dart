import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies_clean_architecture/core/credentials/api_credential.dart';
import 'package:movies_clean_architecture/core/errors/exceptions.dart';
import 'package:movies_clean_architecture/features/movies/data/models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getAllMovies();
  Future<List<MovieModel>> getPopularMovies(int page);
}

String baseUrl = ApiCredential.baseApiUrl.value;

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final http.Client client;

  MovieRemoteDatasourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getAllMovies() async {
    final response = await client.get(
      Uri.parse('$baseUrl/movie/popular').replace(queryParameters: {
        "api_key": ApiCredential.apiKey.value,
        "language": "es-ES"
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          json.decode(response.body) as Map<String, dynamic>;
      final List<MovieModel> movies = decodedJson["results"]
          .map<MovieModel>((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    final response = await client.get(
      Uri.parse('$baseUrl/movie/popular').replace(queryParameters: {
        "api_key": ApiCredential.apiKey.value,
        "language": "es-ES",
        "page": page.toString()
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          json.decode(response.body) as Map<String, dynamic>;
      final List<MovieModel> movies = decodedJson["results"]
          .map<MovieModel>((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
