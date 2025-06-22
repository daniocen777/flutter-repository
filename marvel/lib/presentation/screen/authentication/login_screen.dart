import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/spacing_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Column(
                children: [
                  SvgPicture.asset(
                    dark
                        ? 'assets/vectors/super_woman.svg'
                        : 'assets/vectors/super_woman.svg',
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    TTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    TTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              // Formulario
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: TTexts.email),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        labelText: TTexts.password),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                  // Recuerdame y contraseña olvidada
                  Row(
                    children: [
                      // recuerdame
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          const Text(TTexts.rememberMe),
                        ],
                      ),
                      // contraseña olvidada
                      TextButton(
                        onPressed: () {},
                        child: const Text(TTexts.forgetPassword),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
