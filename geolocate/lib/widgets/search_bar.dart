part of "widgets.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualselection) {
          return Container();
        } else {
          return FadeInDown(child: buildSeacrhbar(context));
        }
      },
    );
  }

  Widget buildSeacrhbar(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          width: _width,
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: GestureDetector(
            onTap: () async {
              final proximity =
                  BlocProvider.of<MyUbicationBloc>(context).state.ubication;
              final historial =
                  BlocProvider.of<SearchBloc>(context).state.historial;
              final SearchResult result = await showSearch(
                  context: context,
                  delegate: SearchDestiny(proximity, historial));
              this._searchResult(context, result);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
              child: Text('Where you going?',
                  style: TextStyle(
                    color: Colors.black87,
                  )),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        offset: Offset(0, 5))
                  ]),
            ),
          )),
    );
  }

  Future<void> _searchResult(BuildContext context, SearchResult result) async {
    calculateAlert(context);
    if (result.cancel) return;
    if (result.manual) {
      BlocProvider.of<SearchBloc>(context).add(OnActivateManualMarker());
      return;
    }
    // Calculando la ruta en base al valor recibido
    final trafficService = new TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final start = BlocProvider.of<MyUbicationBloc>(context).state.ubication;
    final destiny = result.position;
    final DrivingResponse drivingResponse =
        await trafficService.getCoordsStartAndDestiny(start, destiny);

    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;
    // Decodificar
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> coordinatesRoute = points.decodedCoords
        .map((point) => LatLng(point[0], point[1]))
        .toList();
    // Llamar al evento
    mapBloc
        .add(OnCreateRouteStartDestiny(coordinatesRoute, distance, duration));
    Navigator.of(context).pop();
    // Agregar al historial
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(OnAddHistorial(result));
  }
}
