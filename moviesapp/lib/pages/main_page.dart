import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(child: this._buildUI());
  }

  Widget _buildUI() {
    return Scaffold(
      body: Center(child: Text('Holas mundos xxxxx')),
    );
  }
}
