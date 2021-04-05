import 'package:flutter/material.dart';
import 'package:mytelegram/utils/colors.dart';
import 'package:photo_view/photo_view.dart';
/* import 'package:photo_view/photo_view.dart'; */

class FullPhoto extends StatelessWidget {
  final String? url;

  const FullPhoto({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Imagen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FullPhotoScreen(url: this.url),
    );
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String? url;

  const FullPhotoScreen({Key? key, this.url}) : super(key: key);

  @override
  State createState() => FullPhotoScreenState(url: this.url);
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  final String? url;

  FullPhotoScreenState({this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(this.url!),
      ),
    );
  }
}
