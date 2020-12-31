import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:geolocator/geolocator.dart';

part 'my_ubication_event.dart';
part 'my_ubication_state.dart';

class MyUbicationBloc extends Bloc<MyUbicationEvent, MyUbicationState> {
  MyUbicationBloc() : super(MyUbicationState());

  StreamSubscription<Position> _positionSubscription;
  // Iniciar seguimiento cuando se entre al mapa
  void startTracking() {
    // Propiedades del geolocator
    this._positionSubscription = GeolocatorPlatform.instance
        .getPositionStream(
            // desiredAccuracy => Exactitud de la posición
            desiredAccuracy: LocationAccuracy.high,
            // Cambio luego de 10 metros
            distanceFilter: 10)
        .listen((Position position) {
      final newUbication = new LatLng(position.latitude, position.longitude);
      add(OnChangeUbication(newUbication));
    });
    // Disparando evento
  }

  void cancelTracking() {
    this._positionSubscription?.cancel();
  }

  @override
  Stream<MyUbicationState> mapEventToState(
    MyUbicationEvent event,
  ) async* {
    if (event is OnChangeUbication) {
      yield state.copyWith(existUbication: true, ubication: event.ubication);
    }
  }
}
