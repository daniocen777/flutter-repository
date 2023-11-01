import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/article_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
}
