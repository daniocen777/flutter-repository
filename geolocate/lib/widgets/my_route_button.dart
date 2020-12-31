part of "widgets.dart";

class MyRouteButton extends StatelessWidget {
  const MyRouteButton({Key key}) : super(key: key);

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
                Icons.more_horiz,
                color: Colors.black87,
              ),
              onPressed: () {
                mapBloc.add(OnMarkRoute());
              })),
    );
  }
}
