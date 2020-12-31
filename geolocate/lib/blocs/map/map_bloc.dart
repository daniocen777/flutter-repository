import 'package:flutter/material.dart' show Colors;
import 'dart:async';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocate/themes/uber_map_theme.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  // Controlar googleMap
  GoogleMapController _googleMapController;
  // Polylines ruta y destino
  Polyline _route = new Polyline(
      polylineId: PolylineId('route'), color: Colors.transparent, width: 4);

  // Polylines para marcar la ruta de destino
  Polyline _destinyRoute = new Polyline(
      polylineId: PolylineId('destiny_route'), color: Colors.black87, width: 4);

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) {
      this._googleMapController = controller;
      // Cambiar estilo de mapa
      this._googleMapController.setMapStyle(jsonEncode(UBER_MAP_THEME));

      // Llamar al evento
      add(OnMapReady());
    }
  }

  void moveCamera(LatLng destiny) {
    final cameraUpdate = CameraUpdate.newLatLng(destiny);
    // Animar mapa
    this._googleMapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is OnMapReady) {
      yield state.copyWith(mapReady: true);
    } else if (event is OnLocationUpdate) {
      yield* this._onLocationUpdate(event);
    } else if (event is OnMarkRoute) {
      yield* this._onMarkRoute(event);
    } else if (event is OnFollowLocation) {
      if (!state.followLocation) {
        this.moveCamera(this._route.points[this._route.points.length - 1]);
      }
      yield state.copyWith(followLocation: !state.followLocation);
    } else if (event is OnMoveMap) {
      yield state.copyWith(centralUbication: event.centralUbication);
    } else if (event is OnCreateRouteStartDestiny) {
      yield* this._onCreateRouteStartDestiny(event);
    }
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async* {
    // Seguir ubicación
    if (state.followLocation) {
      this.moveCamera(event.ubication);
    }

    // Definir polylines => Listado de todos los puntos que se quiere
    final List<LatLng> points = [...this._route.points, event.ubication];
    this._route = this._route.copyWith(pointsParam: points);
    // Crear el estado
    final currentPolylines = state.polylines;
    currentPolylines['route'] = this._route;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onMarkRoute(OnMarkRoute event) async* {
    if (!state.traceRoute) {
      this._route = this._route.copyWith(colorParam: Colors.black87);
    } else {
      this._route = this._route.copyWith(colorParam: Colors.transparent);
    }
    final currentPolylines = state.polylines;
    currentPolylines['route'] = this._route;
    yield state.copyWith(
        polylines: currentPolylines, traceRoute: !state.traceRoute);
  }

  Stream<MapState> _onCreateRouteStartDestiny(
      OnCreateRouteStartDestiny event) async* {
    this._destinyRoute =
        this._destinyRoute.copyWith(pointsParam: event.coordinates);
    final currentpolylines = state.polylines;
    currentpolylines['destiny_route'] = this._destinyRoute;
    yield state.copyWith(polylines: currentpolylines);
  }
}
