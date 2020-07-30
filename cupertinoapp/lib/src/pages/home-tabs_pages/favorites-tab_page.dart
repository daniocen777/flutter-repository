import 'package:flutter/material.dart';

import 'package:cupertinoapp/src/blocs/master/master_bloc.dart';
import 'package:cupertinoapp/src/blocs/master/master_state.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';
import 'package:cupertinoapp/src/widgets/youtube-video-item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websafe_svg/websafe_svg.dart';


class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MasterBloc>(context);
    return BlocBuilder<MasterBloc, MasterState>(
      builder: (BuildContext context, state) {
        if (state.favorites.length == 0) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                WebsafeSvg.asset(
                  'assets/icons/box.svg',
                  width: 60.0,
                ),
                SizedBox(height: 10.0),
                Text('No hay video para mostrar')
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: state.favorites.length,
          itemBuilder: (BuildContext context, int index) {
            final YouTubeVideo item = state.favorites[index];
            return YouTubeVideoItem(
              item: item,
              onDismissed: () {
                /* bloc.add(MasterRemoveFromHistory(index: index)); */
              },
            );
          },
        );
      },
      condition: (prevState, newState) =>
          prevState.favorites.length != newState.favorites.length,
    );
  }
}
