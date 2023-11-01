import '../../domain/entities/article_entity.dart';
import '../models/article_model.dart';

class ArtivleMapper {
  static ArticleEntity articleModelToEntity(ArticleModel articleModel) =>
      ArticleEntity(
        source: articleModel.source?.name ?? 'no-source',
        author: articleModel.author ?? 'no-author',
        title: articleModel.title ?? 'no-title',
        description: articleModel.description ?? 'no-description',
        url: articleModel.url ?? 'no-url',
        urlToImage: articleModel.urlToImage ?? 'no-image',
        publishedAt: articleModel.publishedAt ?? DateTime.now(),
        content: articleModel.content ?? 'no-content',
      );
}
