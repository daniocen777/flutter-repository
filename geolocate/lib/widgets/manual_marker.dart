part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        if (state.manualselection) {
          return _BuildManualMarker();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildManualMarker extends StatelessWidget {
  const _BuildManualMarker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        /* Botón regresar */
        Positioned(
          top: 70.0,
          left: 20.0,
          child: FadeInLeft(
            child: CircleAvatar(
              maxRadius: 25.0,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  // Cancelar búsqueda manual
                  BlocProvider.of<SearchBloc>(context)
                      .add(OnDeactivateManualMarker());
                },
              ),
            ),
          ),
        ),
        /* Localización */
        Center(
          child: Transform.translate(
            offset: Offset(0, -15.0),
            child: BounceInDown(
              child: Icon(
                Icons.location_on,
                size: 40.0,
              ),
            ),
          ),
        ),
        /* Confirmar destino */
        Positioned(
            bottom: 30.0,
            left: 40.0,
            child: FadeIn(
              child: CupertinoButton(
                color: Colors.black87,
                onPressed: () => this._handleDestiny(context),
                child: Text('Confirm destiny'),
              ),
            )),
      ],
    );
  }

  void _handleDestiny(BuildContext context) async {
    calculateAlert(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final trafficService = new TrafficService();
    final start = BlocProvider.of<MyUbicationBloc>(context).state.ubication;
    final destiny = mapBloc.state.centralUbication;
    final trafficResponse =
        await trafficService.getCoordsStartAndDestiny(start, destiny);
    // Decodificar los puntos de geometry
    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;
    final points =
        Poly.Polyline.Decode(encodedString: geometry.toString(), precision: 6)
            .decodedCoords;
    // Coordenadas para la polylines
    final List<LatLng> coordinates =
        points.map((point) => LatLng(point[0], point[1])).toList();
    mapBloc.add(OnCreateRouteStartDestiny(coordinates, distance, duration));
    // Cerrar la alerta
    Navigator.of(context).pop();
    // Quitar el botón de marcar destino y el de regresar
    BlocProvider.of<SearchBloc>(context).add(OnDeactivateManualMarker());
  }
}
