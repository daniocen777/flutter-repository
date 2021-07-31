import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../global_widgets/circle_button.dart';
import '../../../utils/font_style.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButton(
              iconPath: 'assets/pages/welcome/facebook.svg',
              backgroundColor: Colors.blueAccent,
              onPressed: () => print('Facebook'),
            ),
            SizedBox(width: 10.0),
            CircleButton(
              iconPath: 'assets/pages/welcome/google.svg',
              backgroundColor: Colors.redAccent,
              onPressed: () => print('Facebook'),
            ),
            SizedBox(width: 10.0),
            CircleButton(
              iconPath: 'assets/pages/welcome/apple.svg',
              backgroundColor: Colors.grey,
              onPressed: () => print('Facebook'),
            ),
          ],
        ),
        /* Wrap para evitar error de overflow */
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Expanded(child: Text('¿No tienes una cuenta?')),
            CupertinoButton(
                child: Text(
                  'Nueva cuenta',
                  style: FontStyle.regular,
                ),
                onPressed: () => Navigator.pushNamed(context, Routes.REGISTER))
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
