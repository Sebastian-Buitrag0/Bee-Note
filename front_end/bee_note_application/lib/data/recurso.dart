class Recurso {
    String nombre;
    String tipo;
    String url;
    int tamao;
    DateTime fechaSubida;

    Recurso({
        required this.nombre,
        required this.tipo,
        required this.url,
        required this.tamao,
        required this.fechaSubida,
    });

    factory Recurso.fromJson(Map<String, dynamic> json) => Recurso(
        nombre: json["nombre"],
        tipo: json["tipo"],
        url: json["url"],
        tamao: json["tamaño"],
        fechaSubida: DateTime.parse(json["fechaSubida"]),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "tipo": tipo,
        "url": url,
        "tamaño": tamao,
        "fechaSubida": fechaSubida.toIso8601String(),
    };
}