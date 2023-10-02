import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/http/http.dart';
import '../../domain/datasources/news_datasource.dart';
import '../../domain/entities/article_entity.dart';
import '../mappers/article_mapper.dart';
import '../models/article.dart';
import '../models/article_response.dart';

class NewsAPIDatasource extends NewsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      queryParameters: {
        'apiKey': '742981f7037949c4a2965b055f8a7c43',
        'country': 'us'
      },
    ),
  );

  /*  final Http _http;

  NewsAPIDatasource(this._http); */

  @override
  Future<Either<HttpFailure, List<ArticleEntity>>> getArticles() async {
    /* final result = await _http.request('/top-headlines',
        queryParameters: {'country': 'us'}, onSuccess: (json) {
      final articleResponse = ArticleResponse.fromJson(json);
      List<ArticleEntity> news = articleResponse.articles
          .map((Article article) => ArticleMapper.articleModelToEntity(article))
          .toList();
      return news;
    });

    return result.fold(
        (l) => Left(
            HttpFailure(statusCode: l.statusCode, data: l.data.toString())),
        (r) => Right(r)); */

    ArticleResponse articleResponse =
        ArticleResponse(status: '500', totalResults: -1, articles: []);
    try {
      final response = await dio.get('/top-headlines');
      // print('STATUS =====> ${response.statusCode}');
      if (response.statusCode == 200) {
        articleResponse = ArticleResponse.fromJson(response.data);

        List<ArticleEntity> news = articleResponse.articles
            .map((Article article) =>
                ArticleMapper.articleModelToEntity(article))
            .toList();

        return Right(news);
      } else {
        return Left(
            HttpFailure(statusCode: response.statusCode, data: response.data));
      }
    } catch (e) {
      return Left(HttpFailure(data: e.toString(), exception: e));
    }
  }
}
