import 'dart:convert';

List<Tarea> tareasFromJson(String str) => List<Tarea>.from(json.decode(str).map((x) => Tarea.fromJson(x)));

String tareasToJson(List<Tarea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tarea {
    int id;
    String nombre;
    String descripcion;
    DateTime fechaCreacion;
    DateTime fechaInicio;
    DateTime fechaFin;
    int proyecto;
    int estado;
    int prioridad;

    Tarea({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.fechaCreacion,
        required this.fechaInicio,
        required this.fechaFin,
        required this.proyecto,
        required this.estado,
        required this.prioridad,
    });

    factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        proyecto: json["proyecto"],
        estado: json["estado"],
        prioridad: json["prioridad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaFin": fechaFin.toIso8601String(),
        "proyecto": proyecto,
        "estado": estado,
        "prioridad": prioridad,
    };
}
