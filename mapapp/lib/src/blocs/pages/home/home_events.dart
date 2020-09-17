import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

abstract class HomeEvents {}

/* Notificar el cambio de ubicación del disppsitivo */
class OnMyLocationUpdateEvent extends HomeEvents {
  final LatLng location;

  OnMyLocationUpdateEvent(this.location);
}

/* Al hacer tap al mapa, marcar la ubicación */
class OnMapTapEvent extends HomeEvents {
  final LatLng location;
  OnMapTapEvent(this.location);
}

/* Habilitar GPS */
class OnGpsEnabledEvent extends HomeEvents {
  final bool enabled;

  OnGpsEnabledEvent(this.enabled);
}
