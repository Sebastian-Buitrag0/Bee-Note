class DatosPersonales {
  final String nombre;
  final String apellido;
  final DateTime fechaNacimiento;
  final String telefono;
  final String correo;

  DatosPersonales({
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.telefono,
    required this.correo,
  });

  factory DatosPersonales.fromJson(Map<String, dynamic> json) => DatosPersonales(
        nombre: json["nombre"],
        apellido: json["apellido"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        telefono: json["telefono"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "telefono": telefono,
        "correo": correo,
      };
}