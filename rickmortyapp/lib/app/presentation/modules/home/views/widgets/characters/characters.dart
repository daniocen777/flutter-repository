import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import 'character_tile.dart';

class Character extends StatelessWidget {
  const Character({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();
    final state = controller.state;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
         height: 500,
         width: 400,
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failed: () => const Center(child: Text('ERROR')),
            loaded: (characters) => ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                final character = characters[index];
                return CharacterTile(character: character);
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: characters.length,
            ),
          )),
    );
  }
}
