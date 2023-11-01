part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class GetAllArticleEvent extends ArticleEvent {}

class RefreshArticleEvent extends ArticleEvent {}