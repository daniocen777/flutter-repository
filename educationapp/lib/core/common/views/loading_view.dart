import 'package:educationapp/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            // Se creo una extensión del BuilContext para el tema
            // Evita escribir Theme.of(context)
            context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
