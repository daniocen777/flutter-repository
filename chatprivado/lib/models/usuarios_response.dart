import 'dart:convert';

import 'package:chatprivado/models/usuario.dart';

UsuariosResponse usuariosResponseFromJson(String str) =>
    UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) =>
    json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    this.ok,
    this.msj,
    this.status,
    this.obj,
  });

  bool ok;
  String msj;
  int status;
  List<Usuario> obj;

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(
        ok: json["ok"],
        msj: json["msj"],
        status: json["status"],
        obj: List<Usuario>.from(json["obj"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "status": status,
        "obj": List<dynamic>.from(obj.map((x) => x.toJson())),
      };
}
