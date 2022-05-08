import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class ProgressDialog {
  static void show(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => WillPopScope(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            onWillPop: () async => false));
  }
}
