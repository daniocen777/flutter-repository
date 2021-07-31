import 'package:flutter/material.dart';

class HeadingComponent extends StatelessWidget {
  final String label;
  const HeadingComponent({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Text(
        label,
        style: TextStyle(color:Colors.grey[400]),
      ),
    );

    /* return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        width: 200,
        height: 55.0,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 0.5,
                spreadRadius: 0.5,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            this.label,
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
      ),
    ); */
  }
}
