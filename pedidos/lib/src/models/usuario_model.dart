import 'dart:convert';

Usuarios usuarioFromJson(String str) => Usuarios.fromJson(json.decode(str));

String usuarioToJson(Usuarios data) => json.encode(data.toJson());

class Usuarios {
  bool isError;
  String msj;
  List<Usuario> usuarios;

  Usuarios({
    this.isError,
    this.msj,
    this.usuarios,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        isError: json["is_error"],
        msj: json["msj"],
        usuarios:
            List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_error": isError,
        "msj": msj,
        "usuario": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}

class Usuario {
  int usuarioId;
  String usuario;
  String nombre;
  String email;
  String clave;
  String tipoUsuario;
  String usuarioActualizacion;
  DateTime fechaActualizacion;
  String usuarioCreacion;
  DateTime fechaCreacion;

  Usuario({
    this.usuarioId,
    this.usuario,
    this.nombre,
    this.email,
    this.clave,
    this.tipoUsuario,
    this.usuarioActualizacion,
    this.fechaActualizacion,
    this.usuarioCreacion,
    this.fechaCreacion,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        nombre: json["nombre"],
        email: json["email"],
        clave: json["clave"],
        tipoUsuario: json["tipo_usuario"],
        usuarioActualizacion: (json["usuario_actualizacion"] == null)
            ? null
            : json["usuario_actualizacion"],
        fechaActualizacion: DateTime.parse(json["fecha_actualizacion"]),
        usuarioCreacion: json["usuario_creacion"],
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
      );

  Map<String, dynamic> toJson() => {
        "usuario_id": usuarioId,
        "usuario": usuario,
        "nombre": nombre,
        "email": email,
        "clave": clave,
        "tipo_usuario": tipoUsuario,
        "usuario_actualizacion": usuarioActualizacion,
        "fecha_actualizacion": fechaActualizacion.toIso8601String(),
        "usuario_creacion": usuarioCreacion,
        "fecha_creacion": fechaCreacion.toIso8601String(),
      };
}
