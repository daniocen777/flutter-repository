import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastos_app/src/widgets/category_selector_widget.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String category = "Shopping";
  int value = 0;

  _categorySelector() {
    return Container(
      height: 70.0,
      child: CategorySelectorWidget(categories: {
        "Shopping": Icons.shopping_cart,
        "Alcohol": FontAwesomeIcons.beer,
        "Fast food": FontAwesomeIcons.hamburger,
        "Bills": FontAwesomeIcons.wallet,
      }, onValueChanged: (newCategory) => category = newCategory),
    );
  }

  _currentValue() {
    var realValue = value / 100.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text("\$ ${realValue.toStringAsFixed(2)}",
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent)),
    );
  }

  Widget _num(String text, double height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        child: Center(
            child: Text(text,
                style: TextStyle(fontSize: 25.0, color: Colors.grey))),
      ),
      onTap: () {
        setState(() {
          if (text == ",") {
            value = value * 100;
          } else {
            value = value * 10 + int.parse(text);
          }
        });
      },
    );
  }

  _numpad() {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var height = constraints.biggest.height / 4;
          return Table(
            border: TableBorder.all(color: Colors.grey, width: 1.0),
            children: [
              TableRow(children: [
                _num("1", height),
                _num("2", height),
                _num("3", height),
              ]),
              TableRow(children: [
                _num("4", height),
                _num("5", height),
                _num("6", height),
              ]),
              TableRow(children: [
                _num("7", height),
                _num("8", height),
                _num("9", height),
              ]),
              TableRow(children: [
                _num(",", height),
                _num("0", height),
                GestureDetector(
                  child: Container(
                    height: height,
                    child: Center(
                        child: Icon(Icons.backspace,
                            color: Colors.grey, size: 25.0)),
                  ),
                  onTap: () {
                    setState(() {
                      value = value ~/ 10;
                    });
                  },
                )
              ])
            ],
          );
        },
      ),
    );
  }

  _submit() {
    return Builder(builder: (BuildContext context) {
      return Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: MaterialButton(
            child: Text("Add expense",
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
            onPressed: () {
              if (value > 0 && category != "") {
                // Guardar a la BD
                Firestore.instance.collection("expenses").document().setData({
                  "category": category,
                  "value": value,
                  "month": DateTime.now().month,
                  "day": DateTime.now().day
                });
                Navigator.of(context).pop();
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Select a value and category",
                        style: TextStyle(fontSize: 15.0))));
              }
            }),
      );
    });
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        _categorySelector(),
        _currentValue(),
        _numpad(),
        _submit(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Category",
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      body: _body(),
    );
  }
}
