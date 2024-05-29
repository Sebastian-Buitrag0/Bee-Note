import 'package:bee_note_application/data/datos_personales.dart';
import 'package:bee_note_application/data/recurso.dart';

class User {
  final int id;
  final String nombreUsuario;
  final String password;
  final DatosPersonales datosPersonales;
  final Recurso imgUrl;

  User({
    required this.id,
    required this.nombreUsuario,
    required this.password,
    required this.datosPersonales,
    required this.imgUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombreUsuario: json["nombreUsuario"],
        password: json["password"],
        datosPersonales: DatosPersonales.fromJson(json["datosPersonales"]),
        imgUrl: Recurso.fromJson(json["imagenPerfil"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreUsuario": nombreUsuario,
        "password": password,
        "datosPersonales": datosPersonales.toJson(),
        "imagenPerfil": imgUrl.toJson(),
      };
}