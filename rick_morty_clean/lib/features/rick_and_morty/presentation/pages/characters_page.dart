import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_clean/core/widgets/loading_widget.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/blocs/character_bloc/character_bloc.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/widgets/character_list_widget.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/widgets/message_display_widget.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Characters'));

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CharacterBloc, CharacterState>(
            builder: (BuildContext context, state) {
          if (state is LoadingCharactersState) {
            return const LoadingWidget();
          } else if (state is LoadedCharactersState) {
            return CharacterListWidget(characters: state.characters.results);
          } else if (state is ErrorCharactersState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        }));
  }
}
