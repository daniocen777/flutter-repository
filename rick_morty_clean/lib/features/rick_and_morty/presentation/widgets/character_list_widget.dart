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
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(thickness: 1.0));
  }
}
