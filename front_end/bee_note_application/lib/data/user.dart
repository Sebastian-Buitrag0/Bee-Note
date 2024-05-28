import 'package:bee_note_application/data/datos_personales.dart';
import 'package:bee_note_application/data/recurso.dart';

class User {
  final String nombreUsuario;
  final String password;
  final DatosPersonales datosPersonales;
  final Recurso imgUrl;

  User({
    required this.nombreUsuario,
    required this.password,
    required this.datosPersonales,
    required this.imgUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nombreUsuario: json["nombreUsuario"],
        password: json["password"],
        datosPersonales: DatosPersonales.fromJson(json["datosPersonales"]),
        imgUrl: Recurso.fromJson(json["imagenPerfil"]),
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "password": password,
        "datosPersonales": datosPersonales.toJson(),
        "imagenPerfil": imgUrl.toJson(),
      };
}