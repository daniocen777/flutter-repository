import 'package:flutter/material.dart';
import 'package:country_house/screens/country.dart';
import 'package:dio/dio.dart';

class AllCountries extends StatefulWidget {
  const AllCountries({Key key}) : super(key: key);

  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List _countries = [];
  List _filterCountries = [];
  bool isSeraching = false;
  getCountries() async {
    var response = await Dio().get("https://restcountries.eu/rest/v2/all");
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    getCountries().then((data) {
      setState(() {
        _countries = _filterCountries = data;
      });
    });
  }

  void _filterValue(value) {
    setState(() {
      _filterCountries = _countries
          .where((country) =>
              country["name"].toLowerCase().cotains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSeraching
            ? Text("All Countries")
            : TextField(
                onChanged: (value) {
                  _filterValue(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Search country",
                    icon: Icon(Icons.search, color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white))),
        actions: <Widget>[
          isSeraching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSeraching = false;
                      _filterCountries = _countries;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSeraching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: _filterCountries.length > 0
              ? ListView.builder(
                  itemCount: _filterCountries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Country(
                                  country: _filterCountries[index],
                                )));
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          child: Text(
                            _filterCountries[index]["name"],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
