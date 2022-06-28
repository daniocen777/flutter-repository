import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController? textEditingController;

  const SearchFieldWidget(
      {Key? key,
      required this.height,
      required this.width,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _border = InputBorder.none;
    return Container(
        width: width,
        height: height * 0.05,
        child: TextField(
            controller: textEditingController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                focusedBorder: _border,
                border: _border,
                prefixIcon:
                    const Icon(Icons.search_outlined, color: Colors.white24),
                hintStyle: const TextStyle(color: Colors.white24),
                filled: false,
                fillColor: Colors.white24,
                hintText: 'Search...')));
  }
}
