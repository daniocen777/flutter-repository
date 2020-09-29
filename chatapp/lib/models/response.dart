import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.ok,
    this.msj,
    this.obj,
  });

  bool ok;
  String msj;
  Map<String, dynamic> obj;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        ok: json["ok"],
        msj: json["msj"],
        obj: (json["obj"] != null) ? json["obj"] : {'obj': 'No hay objeto'},
      );

  Map<String, dynamic> toJson() => {"ok": ok, "msj": msj, "obj": obj};
}
