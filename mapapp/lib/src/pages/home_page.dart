import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pages/home/bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  static final route = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* UNI => -12.0231787,-77.0476301,15z */
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    /* this._init(); */
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: this._bloc,
      child: Scaffold(
        body: SafeArea(
          child: Container(
              // Google_maps necesita el tamaño del dispoisitivo
              // Para estilos ver "google maps styles => https://snazzymaps.com/"
              width: double.infinity,
              height: double.infinity,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (BuildContext context, HomeState state) {
                  if (!state.gpsEnabled) {
                    return Center(
                        child: Text('Para utilizar el app, active el GPS',
                            textAlign: TextAlign.center));
                  }

                  if (state.loading) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ));
                  }

                  final CameraPosition initialPosition =
                      CameraPosition(target: state.myLocation, zoom: 17);

                  return GoogleMap(
                    initialCameraPosition: initialPosition,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: state.markers.values.toSet(),
                    onTap: (LatLng position) {
                      this._bloc.add(OnMapTapEvent(position));
                    },
                    onMapCreated: (GoogleMapController controller) {
                      this._bloc.setMapController(controller);
                    },
                  );
                },
              )),
        ),
      ),
    );
  }
}
