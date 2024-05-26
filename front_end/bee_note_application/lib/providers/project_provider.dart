import 'package:bee_note_application/data/project.dart';
import 'package:flutter/foundation.dart';

class ProjectProvider extends ChangeNotifier{
  Proyecto? _proyectoActual;

  Proyecto? get proyectoActual => _proyectoActual;

  set proyectoActual(Proyecto? proyecto) {
    _proyectoActual = proyecto;
    notifyListeners();
  }
}