part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitialState extends CharacterState {}

class LoadingCharactersState extends CharacterState {}

class LoadedCharactersState extends CharacterState {
  final Character characters;

  const LoadedCharactersState({required this.characters});

  @override
  List<Object> get props => [characters];
}

class ErrorCharactersState extends CharacterState {
  final String message;

  const ErrorCharactersState({required this.message});

  @override
  List<Object> get props => [message];
}
