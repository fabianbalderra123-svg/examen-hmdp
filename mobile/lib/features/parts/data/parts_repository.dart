import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/part.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/local_database.dart';
import '../../../core/utils/api_error.dart';

class PartsRepository {
  final ApiService _apiService;
  final LocalDatabase _localDatabase;

  PartsRepository(this._apiService, this._localDatabase);

  Future<List<Part>> listParts({
    int page = 1,
    int pageSize = 100,
    String? search,
    String? categoria,
    String sortBy = 'id',
    String sortOrder = 'asc',
  }) async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/parts',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (search != null) 'search': search,
          if (categoria != null) 'categoria': categoria,
          'sortBy': sortBy,
          'sortOrder': sortOrder,
          'activo': 'true',
        },
      );
      final items = response.data['items'] as List;
      final parts = items.map((json) => Part.fromJson(json as Map<String, dynamic>)).toList();
      if (search == null && categoria == null) {
        await _localDatabase.cacheParts(parts.map((part) => part.toJson()).toList());
      }
      return parts;
    } on DioException catch (e) {
      if (isConnectionError(e)) {
        final cached = await _fromCache(search: search, categoria: categoria);
        if (cached.isNotEmpty) return cached;
      }
      throw mapDioError(e);
    }
  }

  Future<Part> getPart(int id) async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/parts/$id',
      );
      return Part.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (isConnectionError(e)) {
        final cached = await _localDatabase.getCachedParts();
        final match = cached.where((row) => row.id == id).toList();
        if (match.isNotEmpty) return _fromLocal(match.first);
      }
      throw mapDioError(e);
    }
  }

  Future<List<Part>> _fromCache({String? search, String? categoria}) async {
    final cached = await _localDatabase.getCachedParts();
    var parts = cached.map(_fromLocal).toList();
    if (search != null && search.isNotEmpty) {
      final query = search.toLowerCase();
      parts = parts.where((part) {
        return part.nombre.toLowerCase().contains(query) ||
            part.codigo.toLowerCase().contains(query) ||
            (part.marca?.toLowerCase().contains(query) ?? false);
      }).toList();
    }
    if (categoria != null && categoria.isNotEmpty) {
      parts = parts.where((part) => part.categoria == categoria).toList();
    }
    return parts;
  }

  Part _fromLocal(LocalPartData row) {
    return Part(
      id: row.id,
      codigo: row.codigo,
      nombre: row.nombre,
      descripcion: row.descripcion,
      categoria: row.categoria,
      marca: row.marca,
      precioCompra: row.precioCompra,
      precioVenta: row.precioVenta,
      stock: row.stock,
      stockMinimo: row.stockMinimo,
      ubicacion: row.ubicacion,
      activo: row.activo,
    );
  }
}
