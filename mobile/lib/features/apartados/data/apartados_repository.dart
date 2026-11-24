import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/apartado.dart';
import '../../../core/models/part.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/local_database.dart';
import '../../../core/utils/api_error.dart';

class ApartadosRepository {
  final ApiService _apiService;
  final LocalDatabase _localDatabase;

  ApartadosRepository(this._apiService, this._localDatabase);

  Future<List<Apartado>> listApartados({
    int page = 1,
    int pageSize = 50,
    String sortBy = 'fechaCreacion',
    String sortOrder = 'desc',
  }) async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/apartados',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'sortBy': sortBy,
          'sortOrder': sortOrder,
        },
      );
      final items = (response.data['items'] as List)
          .map((json) => json as Map<String, dynamic>)
          .toList();
      await _localDatabase.cacheApartados(items);
      final remote = items.map(Apartado.fromJson).toList();
      final pending = await _pendingApartados();
      return [...pending, ...remote];
    } on DioException catch (e) {
      if (isConnectionError(e)) {
        final cached = await _localDatabase.getCachedApartados();
        final mapped = cached.map(_fromLocal).toList();
        mapped.sort((a, b) => b.fechaCreacion.compareTo(a.fechaCreacion));
        if (mapped.isNotEmpty) return mapped;
      }
      throw mapDioError(e);
    }
  }

  Future<Apartado> getApartado(int id) async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/apartados/$id',
      );
      return Apartado.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<Apartado> createApartado({
    required int piezaId,
    required int cantidad,
    String? nota,
    Part? pieza,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '${AppConfig.apiPath}/apartados',
        data: {
          'piezaId': piezaId,
          'cantidad': cantidad,
          if (nota != null) 'nota': nota,
        },
      );
      return Apartado.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (isConnectionError(e) && pieza != null) {
        return _savePending(
          piezaId: piezaId,
          cantidad: cantidad,
          nota: nota,
          pieza: pieza,
        );
      }
      throw mapDioError(e);
    }
  }

  Future<Apartado> cancelarApartado(int id) async {
    if (id < 0) {
      await _localDatabase.deleteApartado(id);
      return Apartado(
        id: id,
        clienteId: 0,
        piezaId: 0,
        cantidad: 0,
        estado: ApartadoEstado.cancelado,
        fechaCreacion: DateTime.now(),
        pieza: Part(
          id: 0,
          codigo: '',
          nombre: '',
          precioCompra: 0,
          precioVenta: 0,
          stock: 0,
          stockMinimo: 0,
          activo: true,
        ),
        expirado: false,
      );
    }
    try {
      final response = await _apiService.dio.put(
        '${AppConfig.apiPath}/apartados/$id/cancelar',
      );
      return Apartado.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<Apartado> _savePending({
    required int piezaId,
    required int cantidad,
    String? nota,
    required Part pieza,
  }) async {
    final now = DateTime.now();
    final localId = -now.millisecondsSinceEpoch;
    final payload = {
      'id': localId,
      'clienteId': 0,
      'piezaId': piezaId,
      'cantidad': cantidad,
      'estado': 'PENDIENTE',
      'fechaCreacion': now.toIso8601String(),
      'fechaExpiracion': now.add(const Duration(hours: 48)).toIso8601String(),
      'nota': nota,
      'pieza': pieza.toJson(),
      'expirado': false,
    };
    await _localDatabase.savePendingApartado(payload);
    return Apartado.fromJson({...payload, 'pendingSync': true});
  }

  Future<List<Apartado>> _pendingApartados() async {
    final pending = await _localDatabase.getPendingApartados();
    return pending.map(_fromLocal).toList();
  }

  Apartado _fromLocal(LocalApartadoData row) {
    return Apartado(
      id: row.id,
      clienteId: row.clienteId,
      piezaId: row.piezaId,
      cantidad: row.cantidad,
      estado: Apartado.parseEstado(row.estado),
      fechaCreacion: row.fechaCreacion,
      fechaExpiracion: row.fechaExpiracion,
      nota: row.nota,
      pieza: Part.fromJson(jsonDecode(row.piezaJson) as Map<String, dynamic>),
      expirado: row.expirado,
      pendingSync: row.pendingSync,
    );
  }
}
