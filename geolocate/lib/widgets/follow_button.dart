part of "widgets.dart";

class FollowButton extends StatelessWidget {
  const FollowButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Se necesitan los dos blocs
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final myUbicationBloc = BlocProvider.of<MyUbicationBloc>(context);

    return BlocBuilder<MapBloc, MapState>(
      builder: (BuildContext context, MapState state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 25.0,
              child: IconButton(
                  icon: Icon(
                    mapBloc.state.followLocation
                        ? Icons.directions_run
                        : Icons.accessibility,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    mapBloc.add(OnFollowLocation());
                  })),
        );
      },
    );
  }
}
