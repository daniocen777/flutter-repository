import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocate/widgets/widgets.dart';
import 'package:geolocate/blocs/my_ubication/my_ubication_bloc.dart';
import 'package:geolocate/blocs/map/map_bloc.dart';

class MapPage extends StatefulWidget {
  static final String route = "map";

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyUbicationBloc>(context).startTracking();
  }

  @override
  void dispose() {
    BlocProvider.of<MyUbicationBloc>(context).cancelTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[LocationButton(), FollowButton(), MyRouteButton()],
      ),
      body: Stack(
        children: <Widget>[
          BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (BuildContext context, MyUbicationState state) =>
                this._createMap(state),
          ),
          Positioned(top: 15.0, child: SearchBar()),
          ManualMarker()
        ],
      ),
    );
  }

  Widget _createMap(MyUbicationState state) {
    if (!state.existUbication) return Center(child: Text("Searching..."));
    final mapbloc = BlocProvider.of<MapBloc>(context);
    // Disparar el evento para saber la ubicaión y trazar la ruta (polylines)
    mapbloc.add(OnLocationUpdate(state.ubication));
    final cameraPosition =
        new CameraPosition(target: state.ubication, zoom: 15.0);

    return BlocBuilder<MapBloc, MapState>(
      builder: (BuildContext context, state) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) =>
              mapbloc.initMap(controller),
          polylines: mapbloc.state.polylines.values.toSet(),
          onCameraMove: (CameraPosition cameraPosition) {
            mapbloc.add(OnMoveMap(cameraPosition.target));
          },
        );
      },
    );
  }
}
