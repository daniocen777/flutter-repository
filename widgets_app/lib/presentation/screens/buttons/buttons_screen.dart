import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  static const name = 'buttons_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: const _ButtonsView(),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Wrap(
          spacing: 10.0,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {}, child: const Text('Elevated Button')),
            const ElevatedButton(
                onPressed: null, child: Text('Elevated Disable Button')),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.access_alarm_outlined),
              label: const Text('Elevatred Icon'),
            ),
            FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_2_outlined),
              label: const Text('Filled Icon Button'),
            ),
            OutlinedButton(
                onPressed: () {}, child: const Text('Outline Button')),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.baby_changing_station_outlined),
              label: const Text('Outline Icon Button'),
            ),
            TextButton(onPressed: () {}, child: const Text('Text Button')),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.near_me_disabled_outlined),
              label: const Text('Text Icon Button'),
            ),
            // Custom Button
            const CustomButton(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.app_registration_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.app_registration_outlined),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colors.primary),
                iconColor: const MaterialStatePropertyAll(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Material(
        color: colors.primary,
        child: InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Personalizado',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
