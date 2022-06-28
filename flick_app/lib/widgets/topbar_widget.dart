import 'package:flick_app/widgets/search_field_widget.dart';
import 'package:flutter/material.dart';

class TopbarWidget extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController? textEditingController;

  const TopbarWidget(
      {Key? key,
      required this.height,
      required this.width,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.08,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [SearchFieldWidget(height: height, width: width)],
        ));
  }
}
