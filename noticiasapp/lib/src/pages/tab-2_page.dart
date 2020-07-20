import 'package:flutter/material.dart';
import 'package:noticiasapp/src/models/category_model.dart';
import 'package:noticiasapp/src/services/new_service.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[Expanded(child: _Categories())],
      ),
    ));
  }
}

class _Categories extends StatelessWidget {
  const _Categories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewService>(context).categories;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index].name;
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _CategoryButton(category: categories[index]),
              SizedBox(height: 5.0),
              Text('${category[0].toUpperCase()}${category.substring(1)}')
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewService>(context, listen: false);
        newService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}
