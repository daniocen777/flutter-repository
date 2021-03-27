import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

/* 37 */

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription>? cameras;
  CameraController? _cameraController;
  /* List<dynamic>? galeryPhtos; */
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    this.initilizeCamera();
    this.getImagesFromGallery();
    super.initState();
  }

  Future<void> initilizeCamera() async {
    this.cameras = await availableCameras();
    this._cameraController =
        CameraController(cameras![0], ResolutionPreset.medium);
    this._cameraController!.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  Future<void> getImagesFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  Widget _cameraButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 30.0,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(color: Colors.white)),
            ),
            Icon(Icons.camera_alt, size: 30.0, color: Colors.white)
          ],
        ),
      ),
    );
  }

  Widget _galery() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController!.value.isInitialized) {
      return Container();
    }
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(_cameraController!)),
        this._cameraButtonWidget(),
        _galery()
      ],
    );
  }
}
