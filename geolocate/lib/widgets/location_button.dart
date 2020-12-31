part of "widgets.dart";

class LocationButton extends StatelessWidget {
  const LocationButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Se necesitan los dos blocs
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final myUbicationBloc = BlocProvider.of<MyUbicationBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25.0,
          child: IconButton(
              icon: Icon(
                Icons.my_location,
                color: Colors.black87,
              ),
              onPressed: () {
                final destiny = myUbicationBloc.state.ubication;
                mapBloc.moveCamera(destiny);
              })),
    );
  }
}
