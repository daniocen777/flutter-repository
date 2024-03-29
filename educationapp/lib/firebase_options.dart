// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDiNfkT3G9m8RxYWK01iU66-ui3w11ruNU',
    appId: '1:11366545686:web:de7a7e47aa4d6e0cc13837',
    messagingSenderId: '11366545686',
    projectId: 'education-app-d0a2f',
    authDomain: 'education-app-d0a2f.firebaseapp.com',
    storageBucket: 'education-app-d0a2f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDv29A-hL86QEDSGadpjYfMGAZWMeYiXiI',
    appId: '1:11366545686:android:360b3c9dc595a575c13837',
    messagingSenderId: '11366545686',
    projectId: 'education-app-d0a2f',
    storageBucket: 'education-app-d0a2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCH-sRmroHjdid4-alDK1Uudm3lJiOsLww',
    appId: '1:11366545686:ios:cb93cb707b8077c1c13837',
    messagingSenderId: '11366545686',
    projectId: 'education-app-d0a2f',
    storageBucket: 'education-app-d0a2f.appspot.com',
    iosBundleId: 'com.danicode.educationapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCH-sRmroHjdid4-alDK1Uudm3lJiOsLww',
    appId: '1:11366545686:ios:446dbbc9bc9849fbc13837',
    messagingSenderId: '11366545686',
    projectId: 'education-app-d0a2f',
    storageBucket: 'education-app-d0a2f.appspot.com',
    iosBundleId: 'com.danicode.educationapp.RunnerTests',
  );
}
