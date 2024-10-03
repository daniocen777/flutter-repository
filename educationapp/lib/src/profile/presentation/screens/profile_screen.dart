import 'package:educationapp/core/common/widgets/gradient_background.dart';
import 'package:educationapp/core/resources/media_resource.dart';
import 'package:educationapp/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaResource.background,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
