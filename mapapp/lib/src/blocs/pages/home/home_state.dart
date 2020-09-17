import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart' show required;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show LatLng, Marker, MarkerId;
import 'dart:io' show Platform;

class HomeState extends Equatable {
  final LatLng myLocation;
  final bool loading;
  final bool gpsEnabled;
  final Map<MarkerId, Marker> markers; // marcadores al hacer tap

  HomeState(
      {@required this.myLocation, this.loading, this.markers, this.gpsEnabled});

  static HomeState initialState() => HomeState(
      myLocation: LatLng(-12.0231787, -77.0476301),
      loading: true,
      gpsEnabled: Platform.isIOS,
      markers: Map());

  HomeState coyWith(
      {LatLng myLocation,
      bool loading,
      bool gpsEnabled,
      Map<MarkerId, Marker> markers}) {
    return HomeState(
        myLocation: myLocation ?? this.myLocation,
        loading: loading ?? this.loading,
        gpsEnabled: gpsEnabled ?? this.gpsEnabled,
        markers: markers ?? this.markers);
  }

  @override
  List<Object> get props => [myLocation, loading, markers, gpsEnabled];
}
