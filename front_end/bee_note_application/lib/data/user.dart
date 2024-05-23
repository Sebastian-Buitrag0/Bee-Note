import 'package:bee_note_application/data/datos_personales.dart';

class User {
  final String nombreUsuario;
  final String password;
  final DatosPersonales datosPersonales;

  User({
    required this.nombreUsuario,
    required this.password,
    required this.datosPersonales,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nombreUsuario: json["nombreUsuario"],
        password: json["password"],
        datosPersonales: DatosPersonales.fromJson(json["datosPersonales"]),
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "password": password,
        "datosPersonales": datosPersonales.toJson(),
      };
}