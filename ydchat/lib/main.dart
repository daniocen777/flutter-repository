import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ydchat/presentation/bloc/auth/auth_cubit.dart';
import 'package:ydchat/presentation/bloc/phone_auth/phone_auth_cubit.dart';

import 'injection_container.dart' as di;
import 'package:ydchat/presentation/pages/phone_verification_page.dart';
import 'package:ydchat/presentation/screens/welcome_screen.dart';
import 'presentation/pages/set_initial_profile.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/registration_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/widgets/theme/theme.dart';

/* 53 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
   systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color    
  )); */
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted()),
          BlocProvider(create: (_) => di.sl<PhoneAuthCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter whatsaap clone',
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: primaryColor,
              accentColor: secondColor),
          routes: {
            '/': (BuildContext context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (BuildContext context, state) {
                  if (state is Authenticated) {
                    return HomeScreen(
                      uid: state.uid,
                    );
                  }

                  if (state is UnAuthenticated) {
                    return WelcomeScreen();
                  }
                  return Container();
                },
              );
            },
            SplashScreen.route: (BuildContext context) => SplashScreen(),
            HomeScreen.route: (BuildContext context) => HomeScreen(),
            RegistrationScreen.route: (BuildContext context) =>
                RegistrationScreen(),
            WelcomeScreen.route: (BuildContext context) => WelcomeScreen(),
            PhoneVerificationPage.route: (BuildContext context) =>
                PhoneVerificationPage(),
            SetInitialProfilePage.route: (BuildContext context) =>
                SetInitialProfilePage(),
          },
        ));
  }
}
