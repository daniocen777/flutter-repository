import 'package:flutter/material.dart';

import 'package:ydchat/presentation/widgets/calls/single_item_call.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_call),
          onPressed: () {
            print('LLAMAR');
          },
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return SingleItemCall();
          },
        ));
  }
}
