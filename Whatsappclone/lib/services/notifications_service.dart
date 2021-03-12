import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  /* eMLUKxxzQB6J5MOrvvjnkG:APA91bF_IPaMVPyh0HPGM63zDoKyNkWFJf52QDl7GfCDJYR0psP9Q6OrQ7ZLMYNs7I1lDGdZd1lkkd2QQrfWlUa_Sh-aNi5hj6i6e-NISGSy1nn2WTBfn_7tqq9_Evj-xD4YaAAVVe2p */

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print('*************** DATA ***************');
      print(data);
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print('*************** NOTIFICACIÓN ***************');
      print(notification);
    }
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('TOKEN => $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        return;
      },
      /* onBackgroundMessage: myBackgroundMessageHandler, */
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        return;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        return;
      },
    );
  }
}
