import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/article_entity.dart';
import '../../repositories/news_repository.dart';

class GetArticlesUseCase {
  final NewsRepository repository;

  GetArticlesUseCase(this.repository);

  Future<Either<Failure, List<ArticleEntity>>> call() async {
    return await repository.getArticles();
  }
}
