import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:googlemap/src/widgets/dialogs.dart';
import 'package:meta/meta.dart' show required;

class MyApi {
  /* Dio agrega el application/json en los headers */
  final Dio _dio = Dio();

  Future<void> register(BuildContext context,
      {@required String username,
      @required String email,
      @required String password}) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
          'https://curso-api-flutter.herokuapp.com/api/v1/register',
          data: {"username": username, "email": email, "password": password});

      print('ESTATUS => ${response.statusCode}');
      progressDialog.dismiss();

      if (response.statusCode == 200) {
       
        Dialogs.info(context, title: 'GOOD', content: 'User created');
      }
    } catch (e) {
      progressDialog.dismiss();
      print('******* ERROR ******* $e');
      if (e is DioError) {
        Dialogs.info(context,
            title: 'ERROR',
            content: (e.response.statusCode == 409)
                ? 'Duplicated email or username'
                : 'ERROR** => ${e.message}');
      } else {
        print('ERROR in register (class MyApi) => $e');
      }
    }
  }
}
