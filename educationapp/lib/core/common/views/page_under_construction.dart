import 'package:educationapp/core/common/widgets/gradient_background.dart';
import 'package:educationapp/core/resources/media_resource.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaResource.underConstructionBackground,
        child: Center(child: Lottie.asset(MediaResource.emptyLeaderBoard)),
      ),
    );
  }
}
