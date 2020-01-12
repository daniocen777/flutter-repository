import 'package:country_house/screens/country_map.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                back: new CountryDetailCard(
                    title: country["capital"], color: Colors.deepOrange)),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Population"),
                back: new CountryDetailCard(
                    title: country["population"].toString(),
                    color: Colors.deepPurple)),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Flag"),
                back: Card(
                  color: Colors.white,
                  elevation: 10.0,
                  child: Center(
                      child: SvgPicture.network(
                    country["flag"],
                    width: 200.0,
                  )),
                )),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: new CountryCard(title: "Currency"),
                back: new CountryDetailCard(
                    title: country["currencies"][0]["name"],
                    color: Colors.blue)),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CountryMap()));
                },
                child: CountryCard(title: "Show map")),
          ],
        ),
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  final MaterialColor color;
  const CountryDetailCard({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
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
