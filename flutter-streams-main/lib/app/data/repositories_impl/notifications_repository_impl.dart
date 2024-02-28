import 'dart:async';

import 'package:faker/faker.dart';

import '../../domain/models/notification.dart';
import '../../domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl() {
    _init();
  }

  // broadcast => para suscribir varias veves
  final _controller = StreamController<AppNotification>.broadcast();

  Timer? _timer;

  void _init() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final faker = Faker();
      // asegurar que StreamController tenga un oidor y no este cerrado
      if (_controller.hasListener && !_controller.isClosed) {
        _controller.add(AppNotification(
          title: faker.food.dish(),
          body: faker.lorem.sentence(),
          createdAt: DateTime.now(),
        ));
      }
    });
  }

  @override
  Stream<AppNotification> get onNotification => _controller.stream;

  @override
  Future<void> dispose() {
    _timer?.cancel();
    return _controller.close();
  }
}
