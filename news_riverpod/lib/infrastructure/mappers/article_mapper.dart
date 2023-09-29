import '../../domain/entities/article_entity.dart';
import '../models/article.dart';

class ArticleMapper {
  static ArticleEntity articleModelToEntity(Article article) => ArticleEntity(
        source: article.source.name,
        author: (article.author != null) ? article.author! : 'no-author',
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage:
            (article.urlToImage != null) ? article.urlToImage! : 'no-image',
        publishedAt: (article.publishedAt != null)
            ? article.publishedAt!
            : DateTime.now(),
        content: (article.content != null) ? article.content! : 'no-content',
      );
}
