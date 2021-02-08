import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.msj,
    this.status,
    this.obj,
  });

  bool ok;
  String msj;
  int status;
  Map<String, dynamic> obj;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: (json["ok"] != null) ? json["ok"] : false,
        msj: json["msj"] ?? '',
        status: json["status"],
        obj: (json["obj"] != null) ? json["obj"] : {'obj': 'No hay objeto'},
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "status": status,
        "obj": obj,
      };
}
