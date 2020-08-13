import 'package:dio/dio.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:musicapp/src/models/track_model.dart';

class DeezerApi {
  DeezerApi._internal();
  static DeezerApi _instance = DeezerApi._internal();
  static DeezerApi get instance => _instance;

  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://api.deezer.com',
      connectTimeout: 5000,
      receiveTimeout: 10000));

  Future<List<Artist>> getArtists() async {
    final Response response = await _dio.get('/genre/0/artists');
    try {
      if (response.statusCode == 200) {
        List<Artist> artists = (response.data['data'] as List)
            .map<Artist>((json) => Artist.fromJson(json))
            .toList();
        return artists;
      }
      return null;
    } catch (e) {
      print('ERROR => $e');
      return null;
    }
  }

  Future<List<Track>> getTracks(int artistId) async {
    // 10583405
    try {
      final Response response =
          await _dio.get('/artist/$artistId/top?limit=20');
      if (response.statusCode == 200) {
        List<Track> tracks = (response.data['data'] as List)
            .map<Track>((json) => Track.fromJson(json))
            .toList();
        return tracks;
      }
      return null;
    } catch (e) {
      print('ERROR => $e');
      return null;
    }
  }
}
