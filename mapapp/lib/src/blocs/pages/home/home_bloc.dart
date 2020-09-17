import 'dart:async';
import 'dart:typed_data';
import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mapapp/src/utils/extras.dart';
import 'home_events.dart';
import 'home_state.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  final LocationPermissions _locationPermissions = LocationPermissions();
  StreamSubscription<Position> _streamSubscriptionPosition;
  StreamSubscription<ServiceStatus> _streamSubscriptionGpsStatus;
  Completer<GoogleMapController> _completer = Completer();

  HomeBloc() : super(HomeState.initialState()) {
    /* Escuchando los cambios de la ubicación */
    this._init();
  }

  /* Dejar de escuchar los cambios para evitar pérdida de memoria */
  @override
  Future<void> close() async {
    _streamSubscriptionPosition?.cancel();
    _streamSubscriptionGpsStatus?.cancel();
    super.close();
  }

  _init() async {
    this._streamSubscriptionPosition = getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((Position position) async {
      if (position != null) {
        final newPosition = LatLng(position.latitude, position.longitude);
        add(OnMyLocationUpdateEvent(newPosition));
        final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(newPosition);
        await (await _mapController).animateCamera(cameraUpdate);
      }
    });
    // En Andorid, comprobar si el GPS está encendido
    if (Platform.isAndroid) {
      /* final bool enabled = await isLocationServiceEnabled(); */

      this._streamSubscriptionGpsStatus =
          _locationPermissions.serviceStatus.listen((ServiceStatus status) {
        add(OnGpsEnabledEvent(status == ServiceStatus.enabled));
      });
    }
  }

  Future<GoogleMapController> get _mapController async {
    return await _completer.future;
  }

  void setMapController(GoogleMapController controller) {
    if (_completer.isCompleted) {
      _completer = Completer();
    }
    // Asignar el valor al completer
    _completer.complete(controller);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    if (event is OnMyLocationUpdateEvent) {
      yield this.state.coyWith(myLocation: event.location, loading: false);
    } else if (event is OnGpsEnabledEvent) {
      yield this.state.coyWith(gpsEnabled: event.enabled);
    } else if (event is OnMapTapEvent) {
      yield* _onMapTapEventHandler(event);
    }
  }

  Stream<HomeState> _onMapTapEventHandler(OnMapTapEvent event) async* {
    final markerId = MarkerId(this.state.markers.length.toString());
    final info = InfoWindow(
        title: 'Holas ${markerId.value}',
        snippet: 'Dirección de ...',
        anchor: Offset(0.0, 0.0));
    final Uint8List bytes =
        await loadAssets('assets/car-pin.png', width: 50, height: 90);
    final customIcon = BitmapDescriptor.fromBytes(bytes);
    final marker = Marker(
        markerId: markerId,
        position: event.location,
        icon: customIcon,
        anchor: Offset(0.5, 0.5),
        onTap: () {
          print('MarkerId => ${markerId.value}');
        },
        // Cambiar la position
        draggable: true,
        onDragEnd: (LatLng newPosition) {
          print('Nueva Posición => $newPosition');
        },
        infoWindow: info);
    final markers = Map<MarkerId, Marker>.from(this.state.markers);
    markers[markerId] = marker;
    yield this.state.coyWith(markers: markers);
  }
}
