import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/apartado.dart';
import '../../../core/services/api_service.dart';

class ApartadosRepository {
  final ApiService _apiService;

  ApartadosRepository(this._apiService);

  Future<List<Apartado>> listApartados({
    int page = 1,
    int pageSize = 20,
    String sortBy = 'id',
    String sortOrder = 'asc',
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
      final items = response.data['items'] as List;
      return items.map((json) => Apartado.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Apartado> getApartado(int id) async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/apartados/$id',
      );
      return Apartado.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Apartado> createApartado({
    required int piezaId,
    required int cantidad,
    String? nota,
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
      return Apartado.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Apartado> cancelarApartado(int id) async {
    try {
      final response = await _apiService.dio.put(
        '${AppConfig.apiPath}/apartados/$id/cancelar',
      );
      return Apartado.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final message = error.response?.data['message'] ??
          error.response?.statusMessage ??
          'Error desconocido';
      return Exception(message);
    }
    return Exception('Error de conexión: ${error.message}');
  }
}
