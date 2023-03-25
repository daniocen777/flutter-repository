import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_clean/core/errors/failures.dart';
import 'package:rick_morty_clean/core/strings/failures.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/usecases/rick_and_morty_usecase/get_all_characters.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharactersUseCase getAllCharacters;

  CharacterBloc({required this.getAllCharacters})
      : super(CharacterInitialState()) {
    on<CharacterEvent>((event, emit) async {
      if (event is GetAllCharactersEvent) {
        emit(LoadingCharactersState()); 
        final characters = await getAllCharacters();
        emit(_mapFailureOrChraractersToState(characters));
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
