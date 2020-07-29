import 'package:cupertinoapp/src/blocs/master/master_bloc.dart';
import 'package:cupertinoapp/src/blocs/master/master_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_youtube/flutter_youtube.dart';

class YouTubeVideoItem extends StatelessWidget {
  final YouTubeVideo item;

  const YouTubeVideoItem({Key key, @required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final masterBloc = BlocProvider.of<MasterBloc>(context);
    return CupertinoButton(
      onPressed: () {
        /* Emitir el evento MasterAddToHistory para agregar al historial */
        masterBloc.add(MasterAddToHistory(youTubeVideo: item));
        FlutterYoutube.playYoutubeVideoByUrl(
            apiKey: "AIzaSyCS1J_D4c0onYQu2WIXVoO-4I_QanYLJs4",
            videoUrl: "https://www.youtube.com/watch?v=${item.videoId}",
            autoPlay: true, //default falase
            fullScreen: true //default false
            );
      },
      padding: EdgeInsets.zero,
      child: AspectRatio(
        aspectRatio: 12 / 3,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 10.0)
          ]),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: CachedNetworkImage(
                  imageUrl: item.banner,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${item.title}",
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: Text("${item.description}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontWeight: FontWeight.w300)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
