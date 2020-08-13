import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/blocs/home/bloc.dart';
import 'package:musicapp/src/db/app_theme.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:musicapp/src/widgets/rounded_button.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        if (state.status != HomeStatus.selecting) {
          return Container(
            height: 0.0,
          );
        }
        final List<Artist> artistsSelected =
            state.artists.where((element) => element.selected).toList();

        final int count = artistsSelected.length;
        return Container(
          color: MyAppTheme.instance.darkEnabled
              ? MyAppTheme.instance.darkColor
              : Colors.white,
          padding: EdgeInsets.all(10.0),
          child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Select at least 5 artists',
                    style: TextStyle(fontSize: 15.0),
                  )),
                  RoundedButton(
                      onPressed: (count >= 5)
                          ? () {
                              bloc.add(DownloadEvent(artistsSelected));
                            }
                          : null,
                      label: 'Next')
                ],
              )),
        );
      },
    );
  }
}
