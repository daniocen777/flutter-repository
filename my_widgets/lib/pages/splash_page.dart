import 'package:flutter/material.dart';
import 'package:my_widgets/routes/route.dart';

/* Para usar el ciclo de vida, debe ser StatefulWidget */
class SplahPage extends StatefulWidget {
  const SplahPage({super.key});

  @override
  State<SplahPage> createState() => _SplahPageState();
}

class _SplahPageState extends State<SplahPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((_) {
      // Reemplazar el splash para no regresar a ella
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
