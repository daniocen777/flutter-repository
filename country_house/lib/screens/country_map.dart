import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class CountryMap extends StatelessWidget {
  //const CountryMap({Key key}) : super(key: key);

  final _mapController = new MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Country"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              _mapController.move(LatLng(-12.024195, -77.048745), 30);
            },
          )
        ],
      ),
      body: _getMapa(),
    );
  }

  _getMapa() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(center: LatLng(-12.024195, -77.048745), zoom: 30),
      layers: [_crearMap(), _crearMarcadores()],
    );
  }

  _crearMap() {
    // mapbox.[streets, dark, light, outdoors, satellite]
    return TileLayerOptions(
        urlTemplate:
            "https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
        additionalOptions: {
          "accessToken":
              "pk.eyJ1IjoiZGFuaWNvZGU3NzciLCJhIjoiY2s0bGU4anF0MHZpazNrcTh6ejgxNW4wbCJ9.Squ7BTIfCar2R-y_elm3yg",
          "id": "mapbox.streets"
        });
  }

  _crearMarcadores() {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(-12.024195, -77.048745),
          builder: (context) => Container(
              child: Icon(Icons.location_on, size: 60.0, color: Colors.pink)))
    ]);
  }
}
