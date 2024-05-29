class UserIdNombre {
  final int id;
  final String nombreUsuario;

  UserIdNombre({
    required this.id,
    required this.nombreUsuario,
  });

  factory UserIdNombre.fromJson(Map<String, dynamic> json) {
    return UserIdNombre(
      id: json['id'],
      nombreUsuario: json['nombreUsuario'],
    );
  }
}