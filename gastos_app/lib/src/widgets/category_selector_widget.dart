import 'package:flutter/material.dart';

class CategorySelectorWidget extends StatefulWidget {
  final Map<String, IconData> categories;
  final Function(String) onValueChanged;
  CategorySelectorWidget({Key key, this.categories, this.onValueChanged})
      : super(key: key);

  @override
  _CategorySelectorWidgetState createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  String currentItem = "Shopping";
  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widget.categories.forEach((name, icon) {
      widgets.add(GestureDetector(
        child: CategoryWidget(
          name: name,
          icon: icon,
          selected: name == currentItem,
        ),
        onTap: () {
          setState(() {
            currentItem = name;
          });
          widget.onValueChanged(name);
        },
      ));
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: widgets,
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  const CategoryWidget({Key key, this.name, this.icon, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    width: selected ? 3.0 : 1.0,
                    color: selected ? Colors.blueAccent : Colors.grey)),
            child: Icon(icon),
          ),
          Text(name)
        ],
      ),
    );
  }
}
