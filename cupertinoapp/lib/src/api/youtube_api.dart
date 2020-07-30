import 'dart:convert';

import 'package:cupertinoapp/src/models/playlist_model.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class YouTubeApi {
  final String apiKey;

  YouTubeApi({@required this.apiKey}) : assert(apiKey != null);

  String _getUrl(String endPoint, Map<String, String> queryParameters) {
    final uri = Uri(
        scheme: 'https',
        host: 'www.googleapis.com',
        path: 'youtube/v3/$endPoint',
        queryParameters: queryParameters);

    return uri.toString();
  }

  Future<List<PlayList>> getPlayList(String channelId) async {
    try {
      final String url = _getUrl('playlists', {
        'part': 'snippet,contentDetails',
        'channelId': channelId,
        'key': this.apiKey,
        'maxResults': '20'
      });

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        final List<PlayList> items = (parsed['items'] as List)
            .map<PlayList>((item) => PlayList.fromJson(item))
            .toList();
        return items;
      }
      return [];
    } catch (e) {
      print('ERROR => $e');
      return [];
    }
  }

  /* Últimos videos de una canal */
  Future<List<YouTubeVideo>> getNewVideos(String channelId) async {
    try {
      final String url = _getUrl('activities', {
        'part': 'snippet,contentDetails',
        'channelId': channelId,
        'key': this.apiKey,
        'maxResults': '20'
      });

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        final List<YouTubeVideo> items = (parsed['items'] as List)
            .map<YouTubeVideo>((item) => YouTubeVideo.fromJson(item))
            .toList();
        return items;
      }
      return [];
    } catch (e) {
      print('ERROR => $e');
      return [];
    }
  }

  /* Últimos videos de una canal */
  Future<List<YouTubeVideo>> getPlayListVideos(String playListId) async {
    try {
      final String url = _getUrl('playlistItems', {
        'part': 'snippet',
        'playlistId': playListId,
        'key': this.apiKey,
        'maxResults': '50'
      });

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        final List<YouTubeVideo> items = (parsed['items'] as List)
            .map<YouTubeVideo>(
                (item) => YouTubeVideo.fromJson(item, fromPlayList: true))
            .toList();
        return items;
      }
      return [];
    } catch (e) {
      print('ERROR => $e');
      return [];
    }
  }
}
