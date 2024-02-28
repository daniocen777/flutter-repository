import '../models/notification.dart';

abstract class NotificationsRepository {
  Stream<AppNotification> get onNotification;

  Future<void> dispose();
}
