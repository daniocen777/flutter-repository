import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// Modelos
import 'package:share/models/user.dart';
import 'package:share/pages/home.dart';
// Páginas
import 'package:share/widgets/progress.dart';
// Paquete para comprimir
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  final User currentUser;
  Upload({Key key, this.currentUser}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _captionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  File file;
  bool _isUploading = false;
  String _postId = Uuid().v4();
  _handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 675.0, maxWidth: 960.0);
    setState(() {
      this.file = file;
    });
  }

  _handleChooseFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Photo with camera"),
                onPressed: _handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text("Photo with gallery"),
                onPressed: _handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  Container buildSplashScreen() {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "assets/images/upload.svg",
            height: 170.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "Upload image",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                color: Colors.deepOrange,
                onPressed: () => selectImage(context)),
          )
        ],
      ),
    );
  }

  _clearImage() {
    setState(() {
      file = null;
    });
  }

  // Para subir imagen, se debe comprimir
  _compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File("$path/img_$_postId.jpg")
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> _uploadImage(imageFile) async {
    // storageRef => Importadod el home
    StorageUploadTask uploadTask =
        storageRef.child("post_$_postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  _createPostInFirestore(
      {String mediaUrl, String location, String description}) {
    postRef
        .document(widget.currentUser.id)
        .collection("userPosts")
        .document(_postId)
        .setData({
      "postId": _postId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": timestamp,
      "likes": {}
    });
  }

  handleSubmit() async {
    setState(() {
      _isUploading = true;
    });
    await _compressImage();
    String mediaUrl = await _uploadImage(file);
    _createPostInFirestore(
        mediaUrl: mediaUrl,
        location: _locationController.text,
        description: _captionController.text);
    _captionController.clear();
    _locationController.clear();
    setState(() {
      file = null;
      _isUploading = false;
    });
  }

  Scaffold _buildUploadForm() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _clearImage,
          ),
          title: Text("Caption Post", style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton(
              // null => Inhabilita el botón
              onPressed: _isUploading ? null : () => handleSubmit(),
              child: Text("Post",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            _isUploading ? linearProgress() : Text(""),
            Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: FileImage(file))),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(widget.currentUser.photoUrl)),
              title: Container(
                width: 200.0,
                child: TextField(
                  controller: _captionController,
                  decoration: InputDecoration(
                      hintText: "Write a caption...", border: InputBorder.none),
                ),
              ),
            ),
            Divider(),
            ListTile(
                leading: Icon(
                  Icons.pin_drop,
                  color: Colors.deepOrange,
                  size: 35.0,
                ),
                title: Container(
                  width: 200.0,
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: "Where was this photo taken?",
                      border: InputBorder.none,
                    ),
                  ),
                )),
            Container(
              width: 150.0,
              height: 100.0,
              alignment: Alignment.center,
              child: RaisedButton.icon(
                label: Text(
                  "Use current location",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Colors.blue,
                onPressed: getUserLocation,
                icon: Icon(Icons.my_location, color: Colors.white),
              ),
            )
          ],
        ));
  }

  getUserLocation() async {
    print("Entra");
    // desiredAccuracy => presición
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    // Todo lo que se puede sacar:
    /* subThoroughfare => Sub-distrito
       thoroughfare => Vía pública */
    String completeAddress =
        "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}";

    print(completeAddress);
    String formatedAddress = "${placemark.locality}, ${placemark.country}";
    _locationController.text = formatedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : _buildUploadForm();
  }
}
