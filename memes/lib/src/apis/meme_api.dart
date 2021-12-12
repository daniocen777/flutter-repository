import 'package:dio/dio.dart';
import 'package:memes/src/models/api_response.dart';

class MemeApi {
  final Dio _dio = Dio();

  Future<List<Meme>> getMemes() async {
    final String _url = 'https://api.imgflip.com/get_memes';
    List<Meme>? _memes = [];
    try {
      final response = await this._dio.get(_url);
      final apiResponse = ApiResponse.fromJson(response.data);
      _memes = apiResponse.data!.memes;
      return _memes!;
    } catch (e) {
      print('ERROR => $e');
      return [];
    }
  }
}
