class Sucursal {
  final String nombre;
  final String direccion;
  final String telefono;
  final String horario;
  final double latitud;
  final double longitud;

  Sucursal({
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.horario,
    required this.latitud,
    required this.longitud,
  });

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      nombre: json['nombre'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
      horario: json['horario'] as String,
      latitud: (json['coordenadas']['latitud'] as num).toDouble(),
      longitud: (json['coordenadas']['longitud'] as num).toDouble(),
    );
  }
}
