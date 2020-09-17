import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

Future<Uint8List> loadAssets(String path,
    {int width = 50, int height = 50}) async {
  ByteData data = await rootBundle.load(path);
  // Imagen como bytes
  final Uint8List bytes = data.buffer.asUint8List();
  final ui.Codec codec = await ui.instantiateImageCodec(bytes,
      targetWidth: width, targetHeight: height);

  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  data = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}

Future<Uint8List> loadImageNetwork(String url,
    {int width = 50, int height = 50}) async {
  final http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    // Imagen como bytes
    final Uint8List bytes = response.bodyBytes;
    final ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: width, targetHeight: height);

    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final data =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  throw new Exception('dowload failed');
}
