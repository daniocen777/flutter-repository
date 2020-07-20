import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cupertinoapp/src/widgets/circle-container_widget.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget {
  final double size;
  const Avatar({Key key, this.size = 150.0}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File _file;
  final picker = ImagePicker();

  _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size,
        height: widget.size,
        child: Stack(
          children: <Widget>[
            (_file == null)
                ? WebsafeSvg.asset('assets/icons/user.svg')
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.file(_file,
                        width: 200.0, height: 200.0, fit: BoxFit.cover),
                  ),
            Positioned(
                right: 0.0,
                top: 0.0,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 30.0,
                  child: CircleContainer(
                    size: 50.0,
                    child: Icon(Icons.edit),
                  ),
                  onPressed: () => _pickImage(),
                ))
          ],
        ));
  }
}
