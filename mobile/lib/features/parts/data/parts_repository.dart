import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/part.dart';
import '../../../core/services/api_service.dart';

class PartsRepository {
  final ApiService _apiService;

  PartsRepository(this._apiService);

  Future<List<Part>> listParts({
    int page = 1,
    int pageSize = 20,
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
        },
      );
      final items = response.data['items'] as List;
      return items.map((json) => Part.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Part> getPart(int id) async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/parts/$id',
      );
      return Part.fromJson(response.data);
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
