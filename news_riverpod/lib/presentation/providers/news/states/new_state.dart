import 'package:equatable/equatable.dart';

import '../../../../domain/entities/article_entity.dart';

abstract class NewState extends Equatable {
  const NewState();

  @override
  List<Object> get props => [];
}

class NewInitial extends NewState {}

class LoadingNewState extends NewState {}

class LoadedNewState extends NewState {
  const LoadedNewState({required this.articles});

  final List<ArticleEntity> articles;

  @override
  List<Object> get props => [articles];
}

class ErrorNewsState extends NewState {
  const ErrorNewsState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
