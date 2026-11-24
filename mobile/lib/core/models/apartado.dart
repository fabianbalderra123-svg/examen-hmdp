import 'part.dart';

enum ApartadoEstado {
  pendiente,
  confirmado,
  listoParaRecoger,
  entregado,
  cancelado,
}

class Apartado {
  final int id;
  final int clienteId;
  final int piezaId;
  final int cantidad;
  final ApartadoEstado estado;
  final DateTime fechaCreacion;
  final DateTime? fechaExpiracion;
  final String? nota;
  final Part pieza;
  final bool expirado;
  final bool pendingSync;

  Apartado({
    required this.id,
    required this.clienteId,
    required this.piezaId,
    required this.cantidad,
    required this.estado,
    required this.fechaCreacion,
    this.fechaExpiracion,
    this.nota,
    required this.pieza,
    required this.expirado,
    this.pendingSync = false,
  });

  factory Apartado.fromJson(Map<String, dynamic> json) {
    return Apartado(
      id: json['id'] as int,
      clienteId: json['clienteId'] as int,
      piezaId: json['piezaId'] as int,
      cantidad: json['cantidad'] as int,
      estado: parseEstado(json['estado'] as String),
      fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
      fechaExpiracion: json['fechaExpiracion'] != null
          ? DateTime.parse(json['fechaExpiracion'] as String)
          : null,
      nota: json['nota'] as String?,
      pieza: Part.fromJson(json['pieza'] as Map<String, dynamic>),
      expirado: json['expirado'] as bool? ?? false,
      pendingSync: json['pendingSync'] as bool? ?? false,
    );
  }

  static ApartadoEstado parseEstado(String estado) {
    switch (estado.toUpperCase()) {
      case 'PENDIENTE':
        return ApartadoEstado.pendiente;
      case 'CONFIRMADO':
        return ApartadoEstado.confirmado;
      case 'LISTO_PARA_RECOGER':
        return ApartadoEstado.listoParaRecoger;
      case 'ENTREGADO':
        return ApartadoEstado.entregado;
      case 'CANCELADO':
        return ApartadoEstado.cancelado;
      default:
        return ApartadoEstado.pendiente;
    }
  }

  String get estadoTexto {
    switch (estado) {
      case ApartadoEstado.pendiente:
        return 'Pendiente';
      case ApartadoEstado.confirmado:
        return 'Confirmado';
      case ApartadoEstado.listoParaRecoger:
        return 'Listo para recoger';
      case ApartadoEstado.entregado:
        return 'Entregado';
      case ApartadoEstado.cancelado:
        return 'Cancelado';
    }
  }

  bool get puedeCancelar =>
      estado == ApartadoEstado.pendiente ||
      estado == ApartadoEstado.confirmado;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteId': clienteId,
      'piezaId': piezaId,
      'cantidad': cantidad,
      'estado': estado.name.toUpperCase(),
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaExpiracion': fechaExpiracion?.toIso8601String(),
      'nota': nota,
      'pieza': pieza.toJson(),
      'expirado': expirado,
    };
  }
}
