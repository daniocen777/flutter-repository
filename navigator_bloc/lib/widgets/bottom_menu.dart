import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_bloc/classes/bottom_menu_item.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BottomMenu extends StatelessWidget {
  final List<BottomMenuItem> items;
  final int currentPage;
  final void Function(int) onChange; // callBack

  const BottomMenu(
      {Key key,
      @required this.items,
      @required this.currentPage,
      this.onChange})
      : assert(items != null && items.length > 0),
        assert(currentPage != null && currentPage >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: SafeArea(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final BottomMenuItem item = items[index];
              final bool isActive = index == currentPage;
              return Expanded(
                child: Container(
                    child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onChange(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      WebsafeSvg.asset(item.iconPath,
                          width: 30.0,
                          color: isActive ? Colors.blue : Colors.black),
                      SizedBox(height: 3.0),
                      Text(item.label,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: isActive ? Colors.blue : Colors.black))
                    ],
                  ),
                )),
              );
            })),
      ),
    );
  }
}
