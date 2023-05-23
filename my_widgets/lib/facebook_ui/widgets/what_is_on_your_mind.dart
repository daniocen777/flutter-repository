import 'package:flutter/material.dart';
import 'package:my_widgets/facebook_ui/widgets/avatar.dart';

class WhatIsOnYourMind extends StatelessWidget {
  const WhatIsOnYourMind({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Avatar(size: 50.0, asset: 'assets/users/4.jpg'),
        SizedBox(width: 20.0),
        // Flexible => Evitar overflow
        Flexible(
          child: Text(
            '¿En qué estás pensando?',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
