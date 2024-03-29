import 'package:flutter/material.dart' show Widget, BuildContext;

import 'package:rick_morty_clean/features/rick_and_morty/presentation/pages/characters_page.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/pages/splash_page.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/routes/routes.dart';
import 'package:rick_morty_clean/features/rick_and_morty/presentation/widgets/character_detail_widget.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.splash: (_) => const SplashPage(),
      Routes.characters: (_) => const CharactersPage(),
      Routes.characterDetail: (_) => const ChracterDetailWidget(imageUrl: null)
    };
