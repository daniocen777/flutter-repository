import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/menu/menu_item.dart';
import '../../widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // Referencia al scaffold (para la correcta navegación del drawer)
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Widget en Material 3'),
      ),
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (_, int index) {
        final item = appMenuItems[index];
        return _CustomListTile(item: item);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.item,
  });

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(
        item.icon,
        color: colors.primary,
      ),
      title: Text(item.title),
      subtitle: Text(item.subTitle),
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {
        // Navigator.pushNamed(context, item.link);
        // Usando go_router
        context.push(item.link);
      },
    );
  }
}
