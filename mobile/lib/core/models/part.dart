class Part {
  final int id;
  final String codigo;
  final String nombre;
  final String? descripcion;
  final String? categoria;
  final String? marca;
  final double precioCompra;
  final double precioVenta;
  final int stock;
  final int stockMinimo;
  final String? ubicacion;
  final bool activo;

  Part({
    required this.id,
    required this.codigo,
    required this.nombre,
    this.descripcion,
    this.categoria,
    this.marca,
    required this.precioCompra,
    required this.precioVenta,
    required this.stock,
    required this.stockMinimo,
    this.ubicacion,
    required this.activo,
  });

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      id: json['id'] as int,
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      categoria: json['categoria'] as String?,
      marca: json['marca'] as String?,
      precioCompra: (json['precioCompra'] is num
          ? (json['precioCompra'] as num).toDouble()
          : double.parse(json['precioCompra'] as String)),
      precioVenta: (json['precioVenta'] is num
          ? (json['precioVenta'] as num).toDouble()
          : double.parse(json['precioVenta'] as String)),
      stock: json['stock'] as int,
      stockMinimo: json['stockMinimo'] as int,
      ubicacion: json['ubicacion'] as String?,
      activo: json['activo'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'marca': marca,
      'precioCompra': precioCompra,
      'precioVenta': precioVenta,
      'stock': stock,
      'stockMinimo': stockMinimo,
      'ubicacion': ubicacion,
      'activo': activo,
    };
  }
}
