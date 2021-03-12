import 'dart:convert';

MensajeResponse mensajeResponseFromJson(String str) =>
    MensajeResponse.fromJson(json.decode(str));

String mensajeResponseToJson(MensajeResponse data) =>
    json.encode(data.toJson());

class MensajeResponse {
  MensajeResponse({
    this.ok,
    this.msj,
    this.status,
    this.obj,
  });

  bool ok;
  String msj;
  int status;
  Obj obj;

  factory MensajeResponse.fromJson(Map<String, dynamic> json) =>
      MensajeResponse(
        ok: json["ok"],
        msj: json["msj"],
        status: json["status"],
        obj: Obj.fromJson(json["obj"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "status": status,
        "obj": obj.toJson(),
      };
}

class Obj {
  Obj({
    this.mensajes,
  });

  List<Mensaje> mensajes;

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    this.de,
    this.para,
    this.mensaje,
    this.createdAt,
    this.updatedAt,
  });

  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
