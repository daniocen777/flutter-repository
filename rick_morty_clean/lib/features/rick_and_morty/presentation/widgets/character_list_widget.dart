import 'package:flutter/material.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';

class CharacterListWidget extends StatelessWidget {
  final List<Result> characters;

  const CharacterListWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(characters[index].species),
            title: Text(characters[index].name,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold)),
            subtitle: Text(characters[index].location.name,
                style: const TextStyle(fontSize: 12.0)),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(thickness: 1.0));
  }
}
