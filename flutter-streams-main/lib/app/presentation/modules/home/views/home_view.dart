import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../domain/models/notification.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  /* AppNotification? _appNotification;
  StreamSubscription? _subscription;
  NotificationsRepository? _notificationsRepository; */

  /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  } */

  /* void _init() {
    _notificationsRepository = Provider.of(context).notificationsRepository;
    _subscription = _notificationsRepository?.onNotification.listen((event) {
      setState(() {
        _appNotification = event;
      });
    });
  } */

  /*  @override
  void dispose() {
    // _subscription?.cancel();
    _notificationsRepository?.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notificaciones'),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Scaffold())),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<AppNotification>(
                stream:
                    Provider.of(context).notificationsRepository.onNotification,
                builder: (_, snapshot) {
                  if (snapshot.data != null) {
                    return ListTile(
                      title: Text(snapshot.data!.title),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ));
  }
}
