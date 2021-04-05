import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:extended_image/extended_image.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../utils/colors.dart';
import '../widgets/ProgressWidget.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/input_text_widget.dart';
import '../main.dart';

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Configuración',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<InputTextState> _nicknameKey = GlobalKey<InputTextState>();
  final GlobalKey<InputTextState> _aboutMeKey = GlobalKey<InputTextState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferences? _preferences;
  String _id = '';
  String? _nickname;
  String? _aboutMe;
  String photoUrl = '';
  File? _imageFileAvatar;
  bool _isLoading = false;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    this._readDataFromLocal();
  }

  void _readDataFromLocal() async {
    this._preferences = await SharedPreferences.getInstance();
    this._id = this._preferences!.getString('id')!;
    _nickname = this._preferences!.getString('nickname')!;
    _aboutMe = this._preferences!.getString('aboutMe')!;
    this.photoUrl = this._preferences!.getString('photoUrl')!;

    setState(() {});
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        this._imageFileAvatar = File(pickedFile.path);
        this._isLoading = true;
      });
    }

    this.uploadimageToFirestoreAndStorage();
  }

  Future<void> uploadimageToFirestoreAndStorage() async {
    String myFileName = this._id;
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(myFileName);

    try {
      await storageReference.putFile(this._imageFileAvatar!);

      String downloadURL = await storageReference.getDownloadURL();
      this.photoUrl = downloadURL;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(this._id)
          .update({
        'photoUrl': this.photoUrl,
        'aboutMe': this._aboutMe,
        'nickname': this._nickname
      });

      await this._preferences!.setString('photoUrl', this.photoUrl);

      Fluttertoast.showToast(msg: 'Actualización correcta');

      setState(() {
        this._isLoading = false;
      });
    } on firebase_storage.FirebaseException catch (e) {
      Fluttertoast.showToast(msg: '$e');
      setState(() {
        this._isLoading = false;
      });
    }
  }

  void _submit() {
    final String nickname = _nicknameKey.currentState!.value;
    final bool nicknameOk = _nicknameKey.currentState!.isOk;
    final String aboutMe = _aboutMeKey.currentState!.value;
    final bool aboutMeOk = _aboutMeKey.currentState!.isOk;
    if (nicknameOk && aboutMeOk) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(this._id)
          .update({'aboutMe': aboutMe, 'nickname': nickname}).then(
              (data) async {
        await this._preferences!.setString('nickname', nickname);
        await this._preferences!.setString('aboutMe', aboutMe);
        setState(() {
          this._isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Actualización correcta');
      }, onError: (error) {
        Fluttertoast.showToast(msg: '$error');
      });

      setState(() {
        this._isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MyApp()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              /* Avatar */
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(125.0)),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      (this._imageFileAvatar == null)
                          ? (this.photoUrl != '')
                              ? Material(
                                  child: ExtendedImage.network(
                                    this.photoUrl,
                                    cache: true,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.fill,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(125.0)),
                                    shape: BoxShape.circle,
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                )
                              : Icon(Icons.account_circle,
                                  size: 90.0, color: Colors.grey)
                          : Material(
                              child: Image.file(
                                this._imageFileAvatar!,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(125.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                      IconButton(
                          padding: EdgeInsets.all(0.0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.grey,
                          iconSize: 200.0,
                          icon: Icon(Icons.camera_alt,
                              size: 100.0,
                              color: Colors.white54.withOpacity(0.3)),
                          onPressed: getImage)
                    ],
                  ),
                ),
              ),
              /* Para editar */
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(1.0),
                      child: this._isLoading
                          ? CircularProgressWidget()
                          : Container()),
                  /* Usuario */
                  Container(
                    margin: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
                    child: Text('Nombre de perfil:',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: primaryColor)),
                  ),
                  Container(
                      width: 330,
                      child: InputText(
                        key: _nicknameKey,
                        initValue: this._nickname!,
                        iconPath: 'assets/images/user.svg',
                        placeholder: 'Nombre de usuario',
                        validator: (text) {
                          return text.trim().length >= 5;
                        },
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  /* Acerca de mi */
                  Container(
                    margin: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
                    child: Text('Acerca de mí:',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: primaryColor)),
                  ),
                  Container(
                      width: 330,
                      child: InputText(
                        key: _aboutMeKey,
                        initValue: this._aboutMe!,
                        iconPath: 'assets/images/personal-data.svg',
                        placeholder: 'Acerca de mí',
                        validator: (text) {
                          return text.trim().length >= 5;
                        },
                      ))
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              /* Botón */
              CustomButton(
                  text: 'Actualizar', color: primaryColor, onPressed: _submit),
              SizedBox(
                height: 10.0,
              ),
              /* Botón */
              CustomButton(
                  text: 'Cerrar sesión',
                  color: secondColorDark,
                  onPressed: _logout)
            ],
          ),
        )
      ],
    );
  }
}
