import 'package:flutter/material.dart';
import 'package:my_widgets/routes/route.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            // Navigator.popUntil(
            //   context,
            //   (route) {
            //     final name = route.settings.name;
            //     return name == Routes.initialRoute;
            //   },
            // );
            // pushNamedAndRemoveUntil => Elimina varias páginas del historial
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.initialRoute,
              (route) => false,
            );
          },
          child: const Text("LOG OUT"),
        ),
      ),
    );
  }
}
