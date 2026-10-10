import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/sucursal.dart';
import '../../domain/gps_provider.dart';

class GpsScreen extends ConsumerWidget {
  const GpsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sucursalAsync = ref.watch(sucursalProvider);
    final positionAsync = ref.watch(currentPositionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación de la Sucursal'),
      ),
      body: sucursalAsync.when(
        data: (sucursal) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.store,
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                sucursal.nombre,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.location_on, 'Dirección', sucursal.direccion),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.phone, 'Teléfono', sucursal.telefono),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.schedule, 'Horario', sucursal.horario),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tu ubicación',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        positionAsync.when(
                          data: (position) {
                            final distanceAsync = ref.watch(distanceProvider(position));
                            return distanceAsync.when(
                              data: (distance) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.my_location),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.directions_car,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Distancia: ${_formatDistance(distance)}',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              loading: () => const CircularProgressIndicator(),
                              error: (error, stack) => Text('Error: $error'),
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => Column(
                            children: [
                              const Icon(Icons.location_off, size: 48, color: Colors.grey),
                              const SizedBox(height: 8),
                              Text('No se pudo obtener tu ubicación'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => ref.refresh(currentPositionProvider),
                                child: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _openMaps(sucursal),
                    icon: const Icon(Icons.map),
                    label: const Text('Cómo llegar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'TODO: Reemplazar coordenadas con las reales de la sucursal',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(sucursalProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String _formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    }
    return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
  }

  Future<void> _openMaps(Sucursal sucursal) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${sucursal.latitud},${sucursal.longitud}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('No se pudo abrir Google Maps');
    }
  }
}
