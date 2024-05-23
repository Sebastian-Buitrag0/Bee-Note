import 'dart:convert';

Proyecto proyectoFromJson(String str) => Proyecto.fromJson(json.decode(str));

String proyectoToJson(Proyecto data) => json.encode(data.toJson());

class Proyecto {
    int id;
    int estado;
    String nombre;
    String descripcion;
    DateTime fechaCreacion;
    DateTime fechaInicio;
    DateTime fechaFin;

    Proyecto({
        required this.id,
        required this.estado,
        required this.nombre,
        required this.descripcion,
        required this.fechaCreacion,
        required this.fechaInicio,
        required this.fechaFin,
    });

    factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
        id: json["id"],
        estado: json["estado"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estado": estado,
        "nombre": nombre,
        "descripcion": descripcion,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaFin": fechaFin.toIso8601String(),
    };
}
