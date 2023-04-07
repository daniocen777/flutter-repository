part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class GetAllCharactersEvent extends CharacterEvent {}

class GetAllCharactersPaginatedEvent extends CharacterEvent {
  final int page;

  const GetAllCharactersPaginatedEvent({required this.page});

  @override
  List<Object> get props => [page];
}
