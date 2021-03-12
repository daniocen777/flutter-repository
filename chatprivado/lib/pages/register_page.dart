import 'package:chatprivado/blocs/socket/socket_bloc.dart';
import 'package:chatprivado/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatprivado/widgets/custom_textfield.dart';
import 'package:chatprivado/widgets/labels.dart';
import 'package:chatprivado/widgets/logo.dart';
import 'package:chatprivado/widgets/custom_button.dart';
import 'package:chatprivado/blocs/auth/auth_bloc.dart';
import 'package:chatprivado/pages/login_page.dart';
import 'package:chatprivado/pages/usuarios_page.dart';

class RegisterPage extends StatelessWidget {
  static String route = 'register';

  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        if (!state.online) {
          return Scaffold(
              backgroundColor: Color(0xffF2F2F2),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Logo(titulo: 'Registro'),
                        SizedBox(
                          height: 10.0,
                        ),
                        (state.error.length > 0)
                            ? Center(
                                child: Text(state.error,
                                    style: TextStyle(
                                        color: SECOND_COLOR_DARK,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.0)),
                              )
                            : Container(),
                        _Form(),
                        Labels(
                          ruta: LoginPage.route,
                          pregunta: '¿Ya tienes una cuenta?',
                          accion: 'Ir a login',
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              ));
        } else {
          return UsuariosPage();
        }
      },
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final socketBloc = BlocProvider.of<SocketBloc>(context);

    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          CustomTextField(
            textEditingController: nombreController,
            icon: Icons.person,
            hintText: 'Nombre',
          ),
          CustomTextField(
            textEditingController: emailController,
            keyboardType: TextInputType.emailAddress,
            icon: Icons.mail,
            hintText: 'Correo',
          ),
          CustomTextField(
            textEditingController: passwordController,
            obscureText: true,
            icon: Icons.lock,
            hintText: 'Contraseña',
          ),
          SizedBox(height: 20.0),
          CustomButton(
              text: authBloc.state.cargando ? 'Cargando...' : 'Registrar',
              onPressed: authBloc.state.cargando
                  ? null
                  : () {
                      authBloc.add(OnRegisterEvent(
                          nombreController.text,
                          emailController.text.trim(),
                          passwordController.text.trim()));
                          socketBloc.add(OnConnectEvent());
                    })
        ],
      ),
    );
  }
}
