import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../domain/datasource/news_datasource.dart';
import '../../domain/entities/article_entity.dart';
import '../mappers/article_mapper.dart';
import '../models/article_response_model.dart';
import '../utils/http.dart';

class NewsAPIDatasource extends NewsDatasource {
  final Http _http;

  NewsAPIDatasource(this._http);

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles() async {
    final result = await _http.request('/top-headlines',
        queryParameters: {'country': 'us'}, onSuccess: (data) {
      // print('********** DATA ********** \n $data \n ********************');
      return ArticleResponse.fromJson(data);
    });

    return result.fold((l) {
      /*  print(
          '---------- ERROR ---------- \n StatusCode => ${l.statusCode} \n Data => ${l.data} \n Exception => ${l.exception}'); */
      return Left(WrongDataFailure());
    }, (r) {
      /*  print('********** OK ********** => ${r.articles!.length.toString()}'); */

      List<ArticleEntity> articles = r.articles!
          .map((article) => ArtivleMapper.articleModelToEntity(article))
          .toList();
      return Right(articles);
    });
  }
}
