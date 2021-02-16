import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/* cvHUe4MFRW6WqzX5cOKCKd:APA91bHrbpnGKzX0dcxJjzg0I7lpqCRlhXDDny9CRjO-pRXBDM8ChC_rrK20DNneWvU663IVydBBlLU5fpDR6T-UKBaW_tMdQY5iM77Ape3zjH_KDUHVMmgGqTj-bgrNFIQOA-4JbLYC */

class PushNotificationService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();
  Stream<String> get messages => _messageStreamController.stream;
  final _storage = new FlutterSecureStorage();

  dispose() {
    _messageStreamController?.close();
  }

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    // Token de dispositivo
    _firebaseMessaging.getToken().then((token) async {
      await _storage.write(key: 'dispositivo', value: token);
    });

    _firebaseMessaging.configure(
        /* Cuando la aplicación está abierta */
        onMessage: (info) {
      print('********************** onMessage **********************');

      _messageStreamController.sink.add("MENSAJE onMessage");
      return null;
    },
        /* Segundo plano, cuando la aplicación está terminada */
        onLaunch: (info) {
      print('********************** onLaunch **********************');
      _messageStreamController.sink.add("MENSAJE onLaunch");
      return null;
    }, /* onBackgroundMessage: (info) {
      print('********************** onResume **********************');
      _messageStreamController.sink.add("MENSAJE onBackgroundMessage");
      return null;
    }, */ onResume: (info) {
      print('********************** onResume **********************');
      _messageStreamController.sink.add("MENSAJE onResume");
      return null;
    });
  }
}
