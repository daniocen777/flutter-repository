import 'dart:io';

import 'package:flutter/foundation.dart'; // No compatible con web
import 'package:http/http.dart' as http;

class InternetChecker {
  Future<bool> hasInternet() async {
    // dart:io (Garantizar acceso a internet. No compatible con web)
    try {
      // Para saber si hay internet en web (kIsWeb => solo se ejecuta si app corre en web)
      if (kIsWeb) {
        final response = await http.get(Uri.parse('8.8.8.8'));
        return response.statusCode == 200;
      } else {
        final list = await InternetAddress.lookup(
            'google.com'); // enviar solicitud parfa ver si hay internet
        // tenemos acceso a internet
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      return false;
    }
  }
}
