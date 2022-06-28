import 'package:flick_app/widgets/topbar_widget.dart';
import 'package:flutter/material.dart';

class ForegroundWidget extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController? textEditingController;
  const ForegroundWidget(
      {Key? key,
      required this.height,
      required this.width,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: height * 0.88,
        padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TopbarWidget(
                height: height,
                width: width,
                textEditingController: textEditingController)
          ],
        ));
  }
}
