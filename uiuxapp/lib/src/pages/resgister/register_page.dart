import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uiuxapp/src/pages/resgister/widgets/resgister_form.dart';

import '../../pages/resgister/register_controller.dart';
import '../../utils/font_style.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
        create: (BuildContext context) => RegisterController(),
        builder: (context, __) {
          return Scaffold(
              body: SafeArea(
                  child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10.0),
                                Text(
                                  'Registro',
                                  style:
                                      FontStyle.title.copyWith(fontSize: 22.0),
                                ),
                                SizedBox(height: 5.0),
                                Text('Llena los campos y crea tu cuenta',
                                    style: FontStyle.normal.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey)),
                                SizedBox(height: 55.0),
                                RegisterForm()
                              ],
                            ),
                          )))));
        });
  }
}
