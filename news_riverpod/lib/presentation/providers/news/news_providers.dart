import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/http/http.dart';
import '../../../domain/entities/article_entity.dart';
import 'news_repository_provider.dart';
import 'states/new_state.dart';
/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

/* Prividers */
final newsProvider = StateNotifierProvider<NewsNotifier, NewState>((ref) {
  final news = ref.watch(newsRepositoryProvider).getArticles;
  return NewsNotifier(getNews: news);
});

/* Controladores */

typedef GetNewsCallback = Future<Either<HttpFailure, List<ArticleEntity>>>
    Function();

class NewsNotifier extends StateNotifier<NewState> {
  NewsNotifier({required this.getNews}) : super(NewInitial());

  final GetNewsCallback getNews;

  Future<void> loadNews() async {
    final failureOrNews = await getNews();
    failureOrNews.fold(
      (l) {
        state = ErrorNewsState(message: l.data.toString());
      },
      (r) => state = LoadedNewState(articles: r),
    );
  }
}
