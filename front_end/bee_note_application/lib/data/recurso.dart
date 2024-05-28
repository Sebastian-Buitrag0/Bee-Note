class Recurso {
    int id;
    String nombre;
    String tipo;
    String url;
    int tamao;
    DateTime fechaSubida;

    Recurso({
        required this.id,
        required this.nombre,
        required this.tipo,
        required this.url,
        required this.tamao,
        required this.fechaSubida,
    });

    factory Recurso.fromJson(Map<String, dynamic> json) => Recurso(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        url: json["url"],
        tamao: json["tamaño"],
        fechaSubida: DateTime.parse(json["fechaSubida"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
        "url": url,
        "tamaño": tamao,
        "fechaSubida": fechaSubida.toIso8601String(),
    };
}