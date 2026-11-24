import 'package:dio/dio.dart';

bool isConnectionError(DioException error) {
  return error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.connectionError ||
      error.response == null;
}

Exception mapDioError(DioException error) {
  final data = error.response?.data;
  if (data is Map && data['message'] != null) {
    return Exception(data['message'].toString());
  }
  if (isConnectionError(error)) {
    return Exception('Sin conexión con el servidor.');
  }
  return Exception(error.response?.statusMessage ?? 'Error de conexión');
}
