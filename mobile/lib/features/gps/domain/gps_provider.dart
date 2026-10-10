import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/models/sucursal.dart';
import '../../../core/services/api_service.dart';
import '../data/gps_repository.dart';

final gpsRepositoryProvider = Provider<GpsRepository>((ref) {
  return GpsRepository(ref.watch(apiServiceProvider));
});

final sucursalProvider = FutureProvider<Sucursal>((ref) async {
  final repository = ref.watch(gpsRepositoryProvider);
  return repository.getSucursalConfig();
});

final currentPositionProvider = FutureProvider<Position>((ref) async {
  final repository = ref.watch(gpsRepositoryProvider);
  return repository.getCurrentPosition();
});

final distanceProvider = FutureProvider.family<double, Position>((ref, position) async {
  final repository = ref.watch(gpsRepositoryProvider);
  final sucursal = await ref.watch(sucursalProvider.future);
  return repository.calculateDistance(
    position.latitude,
    position.longitude,
    sucursal.latitud,
    sucursal.longitud,
  );
});
