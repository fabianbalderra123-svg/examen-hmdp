import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/client.dart';
import '../../../core/services/api_service.dart';
import '../../../core/utils/api_error.dart';

class AuthException implements Exception {
  final String message;
  final bool unauthorized;

  AuthException(this.message, {this.unauthorized = false});

  @override
  String toString() => message;
}

class AuthRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _storage;

  AuthRepository(this._apiService)
      : _storage = const FlutterSecureStorage();

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
      await _cacheClient(Client.fromJson(response.data['client']));
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
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
      await _cacheClient(Client.fromJson(response.data['client']));
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<Client> getMe() async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/client-auth/me',
      );
      final client = Client.fromJson(response.data['client']);
      await _cacheClient(client);
      return client;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('Sesión expirada', unauthorized: true);
      }
      if (isConnectionError(e)) {
        final cached = await getCachedClient();
        if (cached != null) return cached;
      }
      throw mapDioError(e);
    }
  }

  Future<void> logout() async {
    await _apiService.clearToken();
    await _storage.delete(key: 'client_json');
  }

  Future<Client?> getCachedClient() async {
    final raw = await _storage.read(key: 'client_json');
    if (raw == null) return null;
    return Client.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> _cacheClient(Client client) async {
    await _storage.write(key: 'client_json', value: jsonEncode(client.toJson()));
  }

  ApiService get apiService => _apiService;
}
