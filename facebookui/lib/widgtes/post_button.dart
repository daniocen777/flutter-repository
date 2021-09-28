import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function() onTap;

  const PostButton(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
            color: Colors.white,
            child: InkWell(
                onTap: this.onTap,
                child: Container(
                    height: 25.0,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          this.icon,
                          const SizedBox(width: 4.0),
                          Text(this.label)
                        ])))));
  }
}
