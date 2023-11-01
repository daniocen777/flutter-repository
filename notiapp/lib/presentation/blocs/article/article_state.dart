part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class LoadingArticleState extends ArticleState {}

class LoadedArticleState extends ArticleState {
  final List<ArticleEntity> articles;

  const LoadedArticleState({required this.articles});

  @override
  List<Object> get props => [articles];
}

class ErrorArticleState extends ArticleState   {
  final String message;

  const ErrorArticleState({required this.message});

  @override
  List<Object> get props => [message];
}