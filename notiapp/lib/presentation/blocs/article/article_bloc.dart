import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/article_entity.dart';
import '../../../domain/usecases/news/get_articles_use_case.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;

  ArticleBloc({required this.getArticlesUseCase}) : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) async {
      if (event is GetAllArticleEvent) {
        emit(LoadingArticleState());
        final failureOrArticles = await getArticlesUseCase();
        emit(_mapFailureOrArticleState(failureOrArticles));
      } else {
        emit(const ErrorArticleState(message: 'Error al cargar noticias'));
      }
    });
  }

  ArticleState _mapFailureOrArticleState(
      Either<Failure, List<ArticleEntity>> either) {
    return either.fold(
        (l) => ErrorArticleState(message: _mapFailureToMessage(l)),
        (r) => LoadedArticleState(articles: r));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'serverFailureMessage';
      case EmptyCacheFailure:
        return 'emptyCacheFailureMessage';
      case OfflineFailure:
        return 'offLineFailureMessage';
      default:
        return "Unexpected Error , Please try again later";
    }
  }
}
