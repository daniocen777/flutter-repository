import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool manual; // Ubicación manualk
  final LatLng position;
  final String nameDestiny;
  final String description;

  SearchResult(
      {this.cancel,
      this.manual,
      this.position,
      this.nameDestiny,
      this.description});
}
