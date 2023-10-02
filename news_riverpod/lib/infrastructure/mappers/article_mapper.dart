import '../../domain/entities/article_entity.dart';
import '../models/article.dart';

class ArticleMapper {
  static ArticleEntity articleModelToEntity(Article article) => ArticleEntity(
        source:
            (article.source.name != null) ? article.source.name! : 'no-source',
        author: (article.author != null) ? article.author! : 'no-author',
        title: (article.title != null) ? article.title! : 'no-title',
        description: (article.description != null)
            ? article.description!
            : 'no-description',
        url: (article.url != null) ? article.url! : 'no-url',
        urlToImage: (article.urlToImage != null)
            ? article.urlToImage!
            : 'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
        publishedAt: (article.publishedAt != null)
            ? article.publishedAt!
            : DateTime.now(),
        content: (article.content != null) ? article.content! : 'no-content',
      );
}
