import 'package:dartz/dartz.dart';

import '../../core/http/http.dart';
import '../entities/article_entity.dart';

abstract class NewsDatasource {
  Future<Either<HttpFailure, List<ArticleEntity>>> getArticles();
}
