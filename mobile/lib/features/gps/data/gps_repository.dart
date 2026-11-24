import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/sucursal.dart';
import '../../../core/services/api_service.dart';
import '../../../core/utils/api_error.dart';

class GpsRepository {
  final ApiService _apiService;

  GpsRepository(this._apiService);

  Future<Sucursal> getSucursalConfig() async {
    try {
      final response = await _apiService.dio.get(
        '${AppConfig.apiPath}/sucursal/config',
      );
      return Sucursal.fromJson(response.data);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('El servicio de ubicación está deshabilitado');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permiso de ubicación denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permiso de ubicación denegado permanentemente');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

}
