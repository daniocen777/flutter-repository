import 'package:dartz/dartz.dart';

import '../../core/http/http.dart';
import '../../domain/datasources/news_datasource.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  NewsRepositoryImpl(this.datasource);

  final NewsDatasource datasource;

  @override
  Future<Either<HttpFailure, List<ArticleEntity>>> getArticles() {
    return datasource.getArticles();
  }
}
