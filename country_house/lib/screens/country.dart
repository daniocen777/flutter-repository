import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Country extends StatelessWidget {
  final country;
  const Country({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(country["name"]),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Capital"),
                back: new CountryDetailCard(title: country["capital"])),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Population"),
                back: new CountryDetailCard(title: country["population"].toString())),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Flag"),
                back: new CountryDetailCard(title: country["flag"])),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Currency"),
                back: new CountryDetailCard(title: country["name"])),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Show map"),
                back: new CountryDetailCard(title: country["name"])),
          ],
        ),
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  const CountryDetailCard({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      elevation: 10.0,
      child: Center(
          child: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white))),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  const CountryCard({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      )),
    );
  }
}
