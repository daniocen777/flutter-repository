import 'package:flutter/material.dart';
import 'package:astrid_allison_game/src/ui/global/controllers/theme_controller.dart';
import 'package:astrid_allison_game/src/ui/global/widgets/my_icon_button.dart';
import 'package:astrid_allison_game/src/ui/icons/puzzle_icons.dart';
import 'package:astrid_allison_game/src/ui/pages/game/controller/game_controller.dart';
import 'package:astrid_allison_game/src/ui/utils/dark_mode_extension.dart';
import 'package:astrid_allison_game/src/ui/utils/platform.dart';
import 'package:provider/provider.dart';

const whiteFlutterLogoColorFilter = ColorFilter.matrix(
  [1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0],
);

class GameAppBar extends StatelessWidget {
  const GameAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo = isIOS
        ? const Icon(
            PuzzleIcons.heart,
            color: Colors.redAccent,
            size: 30,
          )
        : Image.asset(
            "assets/images/pug2.png",
            width: 70.0,
            height: 70.0,
          );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            FittedBox(
              child: Text.rich(
                TextSpan(
                  text: "${isIOS ? "Created" : "Con cariño"}\n",
                  children: const [
                    TextSpan(
                      text: "A jugar",
                      style: TextStyle(
                        fontSize: 24,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 5),
            if (context.isDarkMode)
              ColorFiltered(
                colorFilter: whiteFlutterLogoColorFilter,
                child: logo,
              )
            else
              logo,
            const Spacer(),
            Consumer<GameController>(
              builder: (_, controller, __) => Row(
                children: [
                  MyIconButton(
                    onPressed: controller.toggleVibration,
                    iconData: controller.state.vibration
                        ? PuzzleIcons.vibration
                        : PuzzleIcons.vibration_off,
                  ),
                  const SizedBox(width: 10),
                  MyIconButton(
                    onPressed: controller.toggleSound,
                    iconData: controller.state.sound
                        ? PuzzleIcons.sound
                        : PuzzleIcons.mute,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Consumer<ThemeController>(
              builder: (_, controller, __) => MyIconButton(
                onPressed: controller.toggle,
                iconData: controller.isDarkMode
                    ? PuzzleIcons.dark_mode
                    : PuzzleIcons.brightness,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
