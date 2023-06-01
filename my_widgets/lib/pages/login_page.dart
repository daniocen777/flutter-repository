import 'package:flutter/material.dart';
import 'package:my_widgets/pages/profile_page.dart';

class LoginPage extends StatelessWidget {
  final String? email;

  const LoginPage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ),
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                final route = MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                );
                Navigator.push(context, route);
              },
              child: Text('LOGIN PAGE $email'),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => Container(
                  height: 70,
                  color: Colors.primaries[index],
                ),
                itemCount: Colors.primaries.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
