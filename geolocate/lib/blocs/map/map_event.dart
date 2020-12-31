part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent {}

// Marcar recorrido
class OnMarkRoute extends MapEvent {}

// Seguir ubicación
class OnFollowLocation extends MapEvent {}

// Dibujay ruta de inicio y destino
class OnCreateRouteStartDestiny extends MapEvent {
  final List<LatLng> coordinates;
  final double distance;
  final double duration;

  OnCreateRouteStartDestiny(this.coordinates, this.distance, this.duration);
}

// Mover mapa al centro
class OnMoveMap extends MapEvent {
  final LatLng centralUbication;

  OnMoveMap(this.centralUbication);
}

// Nuevo punto en la polyline
class OnLocationUpdate extends MapEvent {
  final LatLng ubication; // Recibe la ubicación

  OnLocationUpdate(this.ubication);
}
