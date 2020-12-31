import 'dart:async';

import 'package:dio/dio.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:geolocate/helpers/helpers.dart';
import 'package:geolocate/models/search_response.dart';
import 'package:geolocate/models/traffic_response.dart';

/* %2C, => ,  
  53B => ; */

/* https://api.mapbox.com/directions/v5/mapbox/driving/-77.03092985019728,-12.062784259113656;-77.02190301430248,-12.069442187439392?alternatives=true&language=es&geometries=geojson&steps=true&access_token=pk.eyJ1IjoiZGFuaWNvZGU3NzciLCJhIjoiY2tqMDB6cTZ0MmpzbTJ1cnhwNnlmanI0ZCJ9.KPnblz7NzePr9zeV98kwhQ */

class TrafficService {
  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  // Debouncer
  final _debouncer = Debouncer<String>(duration: Duration(milliseconds: 500));
  final StreamController<SearchResponse> _sugerenciasStreamController =
      new StreamController<SearchResponse>.broadcast();
  // Get Del Stream
  Stream<SearchResponse> get sugerenciasStream =>
      this._sugerenciasStreamController.stream;

  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1IjoiZGFuaWNvZGU3NzciLCJhIjoiY2tqMDB6cTZ0MmpzbTJ1cnhwNnlmanI0ZCJ9.KPnblz7NzePr9zeV98kwhQ';

  void close() {
    _sugerenciasStreamController.close();
  }

  Future<DrivingResponse> getCoordsStartAndDestiny(
      LatLng start, LatLng destiny) async {
    final coordinates =
        '${start.longitude},${start.latitude};${destiny.longitude},${destiny.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordinates';
    final response = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(response.data);

    return data;
  }

  Future<SearchResponse> getResultQuery(String search, LatLng proximity) async {
    final url = '${this._baseUrlGeo}/mapbox.places/$search.json';
    try {
      final response = await _dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity': '${proximity.longitude}, ${proximity.latitude}',
        'language': 'es',
      });

      final SearchResponse searchResponse =
          searchResponseFromJson(response.data);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    _debouncer.value = '';
    _debouncer.onValue = (value) async {
      final resultados = await this.getResultQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      _debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }
}
