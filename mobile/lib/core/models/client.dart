class Client {
  final int id;
  final String nombre;
  final String email;
  final String? telefono;
  final String? direccion;
  final DateTime createdAt;

  Client({
    required this.id,
    required this.nombre,
    required this.email,
    this.telefono,
    this.direccion,
    required this.createdAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      email: json['email'] as String,
      telefono: json['telefono'] as String?,
      direccion: json['direccion'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
