import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/article_entity.dart';

abstract class NewsDatasource {
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
}
