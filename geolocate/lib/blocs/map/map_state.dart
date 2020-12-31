part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady; // Si el mapa está lista para mostrarse
  final bool traceRoute; // si se quiere trazar recorrido
  final bool followLocation; // Seguir ubicación
  final LatLng centralUbication; // Ubicacipón central
  // Polylines => línea con todos sus puntos
  final Map<String, Polyline> polylines;

  MapState(
      {this.mapReady = false,
      this.traceRoute = false,
      this.followLocation = false,
      this.centralUbication,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? Map();

  MapState copyWith(
      {bool mapReady,
      bool traceRoute,
      bool followLocation,
      LatLng centralUbication,
      Map<String, Polyline> polylines}) {
    return MapState(
        mapReady: mapReady ?? this.mapReady,
        traceRoute: traceRoute ?? this.traceRoute,
        polylines: polylines ?? this.polylines,
        followLocation: followLocation ?? this.followLocation,
        centralUbication: centralUbication ?? this.centralUbication);
  }
}
