import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/app_config.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: AppConfig.apiTimeout,
          receiveTimeout: AppConfig.apiTimeout,
        )),
        _storage = const FlutterSecureStorage() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          _storage.delete(key: 'auth_token');
        }
        handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;

  Future<void> setToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }
}
