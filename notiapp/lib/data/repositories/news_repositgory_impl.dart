import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../domain/datasource/news_datasource.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsDatasource datasource;

  NewsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles() {
    return datasource.getArticles();
  }
}
