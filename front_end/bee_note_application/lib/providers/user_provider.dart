import 'package:bee_note_application/data/recurso.dart';
import 'package:flutter/foundation.dart';
import 'package:bee_note_application/data/datos_personales.dart';

class UserProvider extends ChangeNotifier {
  int? usuarioId;
  DatosPersonales? datosPersonales;
  String? nombreUsuario;
  String? password;
  Recurso? imagenPerfil;

  void updateUsuarioId(int value) {
    usuarioId = value;
    notifyListeners();
  }

  void updateDatosPersonales(DatosPersonales value) {
    datosPersonales = value;
    notifyListeners();
  }

  void updateNombreUsuario(String value) {
    nombreUsuario = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateImagenPerfil(Recurso? value) {
    imagenPerfil = value;
    notifyListeners();
  }
}