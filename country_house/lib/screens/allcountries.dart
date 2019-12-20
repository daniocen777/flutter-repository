import 'package:country_house/screens/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  const AllCountries({Key key}) : super(key: key);

  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  Future<List> _countries;
  int _length;
  Future<List> getCountries() async {
    var response = await Dio().get("https://restcountries.eu/rest/v2/all");
    _length = response.data.length;
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    _countries = getCountries();
  }

  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("All Countries"),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<List>(
            future: _countries,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: _length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Country(country: snapshot.data[index])));
                          },
                          child: Card(
                            elevation: 10.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              child: Text(
                                snapshot.data[index]["name"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ));
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
