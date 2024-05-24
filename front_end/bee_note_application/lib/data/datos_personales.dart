class DatosPersonales {
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
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
        fechaNacimiento: json["fechaNacimiento"],
        telefono: json["telefono"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "fechaNacimiento": fechaNacimiento,
        "telefono": telefono,
        "correo": correo,
      };
}