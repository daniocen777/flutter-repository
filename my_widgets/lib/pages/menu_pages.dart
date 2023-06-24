// import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
/* import 'package:my_widgets/pages/login_page.dart'; */
import 'package:my_widgets/routes/route.dart';

class PageData {
  final String name;
  final String label;
  final Object? arguments;
  final void Function(Object?)? onResult;

  const PageData(
      {required this.name, required this.label, this.arguments, this.onResult});
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color _color = Colors.red;
  late List<PageData> _pages;

  /* void _onTap(BuildContext context) {
    final faker = Faker();
    final email = faker.internet.email();
    Navigator.pushNamed(context, Routes.login, arguments: email);
    /* final route = MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(
              email: email,
            )); */

    // Navigator.push(context, route);
  } */

  @override
  void initState() {
    super.initState();
    _pages = <PageData>[
      const PageData(
          name: Routes.login, label: 'Go to Login', arguments: 'test@test.com'),
      PageData(
        name: Routes.colorPicker,
        label: 'Go to Color Picker',
        onResult: (result) {
          if (result is Color) {
            _color = result;
            setState(() {});
          }
        },
      ),
      const PageData(name: Routes.dialogs, label: 'Go to Dialogs'),
      const PageData(name: Routes.textField, label: ' INPUT TextField'),
      const PageData(name: Routes.checkBox, label: ' INPUT CheckBox')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: _color),
        body: ListView.builder(
          itemCount: _pages.length,
          itemBuilder: (_, int index) {
            final data = _pages[index];
            return ListTile(
              title: Text(data.label),
              onTap: () async {
                final result = await Navigator.pushNamed(context, data.name,
                    arguments: data.arguments);
                if (data.onResult != null) {
                  data.onResult!(result);
                }
              },
            );
          },
        ));
  }
}
