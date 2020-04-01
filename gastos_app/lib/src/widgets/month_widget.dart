import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastos_app/src/widgets/graph_widget.dart';

class MonthWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;

  MonthWidget({Key key, this.documents})
      : total = documents.map((doc) => doc["value"]).fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents
              .where((doc) => doc["day"] == (index + 1))
              .map((doc) => doc["value"])
              .fold(0.0, (a, b) => a + b);
        }),
        categories = documents.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document["category"])) {
            map[document["category"]] = 0.0;
          }

          map[document["category"]] += document["value"];

          return map;
        }),
        super(key: key);

  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: <Widget>[
          _expenses(),
          _graph(size),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          ),
          _list()
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          "\$ ${widget.total.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Text("Total expenses",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.blueGrey))
      ],
    );
  }

  Widget _graph(size) {
    return Container(
        height: size.height * 0.3, child: GraphWidget(data: widget.perDay));
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categories.keys.elementAt(index);
          var data = widget.categories[key];
          return _item(FontAwesomeIcons.shoppingCart, key,
              100 * data ~/ widget.total, data);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 2.0,
          );
        },
      ),
    );
  }

  _item(IconData icon, String name, int porcent, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20.0,
      ),
      title: Text(name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
      subtitle: Text("$porcent% of expenses",
          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey)),
      trailing: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\$ $value",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500)))),
    );
  }
}
