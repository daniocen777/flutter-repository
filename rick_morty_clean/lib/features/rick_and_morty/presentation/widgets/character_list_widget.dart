import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';
/* import 'package:rick_morty_clean/features/rick_and_morty/presentation/blocs/character_bloc/character_bloc.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/routes/routes.dart'; */
import 'package:rick_morty_clean/features/rick_and_morty/presentation/widgets/character_detail_widget.dart';

class CharacterListWidget extends StatelessWidget {
  final List<Result> characters;

  const CharacterListWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    // final characterBloc = BlocProvider.of<CharacterBloc>(context);

    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(childCount: characters.length,
                (context, index) {
          return ListTile(
            leading: Text(characters[index].id.toString()),
            title: Text(characters[index].name,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold)),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text('Status:',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                    Text(characters[index].status,
                        style: const TextStyle(fontSize: 12.0))
                  ],
                ),
                Row(
                  children: [
                    const Text('Species:',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                    Text(characters[index].species,
                        style: const TextStyle(fontSize: 12.0))
                  ],
                ),
              ],
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChracterDetailWidget(
                        imageUrl: characters[index].image))),
          );
        }))
      ],
    );
  }
}
