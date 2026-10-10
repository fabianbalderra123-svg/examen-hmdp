import 'package:dio/dio.dart';
import '../../../core/models/client.dart';
import '../../../core/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<Map<String, dynamic>> register({
    required String nombre,
    required String email,
    required String password,
    String? telefono,
    String? direccion,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '${AppConfig.apiPath}/client-auth/register',
        data: {
          'nombre': nombre,
          'email': email,
          'password': password,
          if (telefono != null) 'telefono': telefono,
          if (direccion != null) 'direccion': direccion,
        },
      );
      await _apiService.setToken(response.data['token']);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '${AppConfig.apiPath}/client-auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      await _apiService.setToken(response.data['token']);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Client> getMe() async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/client-auth/me',
      );
      return Client.fromJson(response.data['client']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    await _apiService.clearToken();
  }

  ApiService get apiService => _apiService;

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
