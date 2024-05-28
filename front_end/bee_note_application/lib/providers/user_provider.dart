import 'package:flutter/foundation.dart';
import 'package:bee_note_application/data/datos_personales.dart'; // Asegúrate de que este es el camino correcto al modelo

class UserProvider extends ChangeNotifier {
  int? usuarioId;
  DatosPersonales? datosPersonales;
  String? nombreUsuario;
  String? password;
  String? imagenPerfilUrl;

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

  void updateImagenPerfilUrl(String? value) {
    imagenPerfilUrl = value;
    notifyListeners();
  }
}