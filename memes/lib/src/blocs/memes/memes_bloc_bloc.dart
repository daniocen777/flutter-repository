import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:memes/src/apis/meme_api.dart';
import 'package:memes/src/models/api_response.dart';

part 'memes_bloc_event.dart';
part 'memes_bloc_state.dart';

class MemesBlocBloc extends Bloc<MemesBlocEvent, MemesState> {
  final _api = MemeApi();

  MemesBlocBloc() : super(MemesInitialState()) {
   

    on<GetmemesEvent>((event, emit) async {
      final List<Meme> memes = await this._api.getMemes();
      emit(state.copyWith(memes: memes));
    });
  }

}
