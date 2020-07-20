import 'dart:convert';

import 'package:http/http.dart' as http;

class AccountApi {
  Future<bool> login(String email, String password) async {
    try {
      final http.Response response = await http.post(
          "https://reqres.in/api/login",
          body: jsonEncode({"email": email, "password": password, "age": 25}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final dynamic parsed = jsonDecode(response.body);
        print("login OK ${parsed["token"]}");
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
