import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_clean/core/errors/failures.dart';
import 'package:rick_morty_clean/core/strings/failures.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/usecases/rick_and_morty_usecase/get_all_characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/usecases/rick_and_morty_usecase/get_all_characters_paginated.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharactersUseCase getAllCharacters;
  final GetAllCharactersPaginatedUseCase getAllCharactersPaginated;

  CharacterBloc(
      {required this.getAllCharacters, required this.getAllCharactersPaginated})
      : super(CharacterInitialState()) {
    on<CharacterEvent>((event, emit) async {
      if (event is GetAllCharactersPaginatedEvent) {
        emit(LoadingCharactersState());
        final characters = await getAllCharactersPaginated(event.page);
        emit(_mapFailureOrChraractersToState(characters));
      } else {
        print('****** NO EVENTO ******');
      }
    });
  }

  CharacterState _mapFailureOrChraractersToState(
      Either<Failure, Character> either) {
    return either.fold(
      (failure) => ErrorCharactersState(message: _mapFailureToMessage(failure)),
      (characters) => LoadedCharactersState(characters: characters),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offLineFailureMessage;
      default:
        return "Unexpected Error , Please try again later";
    }
  }
}
