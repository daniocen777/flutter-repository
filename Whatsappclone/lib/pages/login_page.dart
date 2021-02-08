import 'package:Whatsappclone/blocs/socket/socket_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Whatsappclone/utils/colors.dart';
import 'package:Whatsappclone/blocs/auth/auth_bloc.dart';
import 'package:Whatsappclone/widgets/custom_textfield.dart';
import 'package:Whatsappclone/widgets/custom_button.dart';
import 'package:Whatsappclone/widgets/labels.dart';
import 'package:Whatsappclone/widgets/logo.dart';
import 'package:Whatsappclone/pages/register_page.dart';
import 'package:Whatsappclone/pages/usuarios_page.dart';

class LoginPage extends StatelessWidget {
  static String route = 'login';

  const LoginPage({Key key}) : super(key: key);

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
                          Logo(titulo: 'Iniciar Sesión'),
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
                            ruta: RegisterPage.route,
                            pregunta: '¿No tienes cuenta?',
                            accion: 'Crea una cuenta aquí',
                          ),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    )),
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
              text: authBloc.state.cargando ? 'Cargando...' : 'Ingresar',
              onPressed: authBloc.state.cargando
                  ? null
                  : () {
                      authBloc.add(OnLoginEvent(emailController.text.trim(),
                          passwordController.text.trim()));
                      socketBloc.add(OnConnectEvent());
                    })
        ],
      ),
    );
  }
}
