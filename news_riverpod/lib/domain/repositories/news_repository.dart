import 'package:dartz/dartz.dart';

import '../../core/http/http.dart';
import '../entities/article_entity.dart';

abstract class NewsRepository {
  Future<Either<HttpFailure, List<ArticleEntity>>> getArticles();
}
