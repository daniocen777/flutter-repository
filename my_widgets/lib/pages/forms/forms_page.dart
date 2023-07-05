import 'package:flutter/material.dart';
import 'package:my_widgets/pages/menu_pages.dart';
import 'package:my_widgets/routes/route.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  late List<PageData> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const <PageData>[
      PageData(name: Routes.loginForm, label: 'Go to LOGIN FORM')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber[900]),
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
