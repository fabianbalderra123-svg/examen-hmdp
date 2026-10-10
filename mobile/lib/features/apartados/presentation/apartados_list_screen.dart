import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/apartado.dart';
import '../../domain/apartados_provider.dart';

class ApartadosListScreen extends ConsumerStatefulWidget {
  const ApartadosListScreen({super.key});

  @override
  ConsumerState<ApartadosListScreen> createState() => _ApartadosListScreenState();
}

class _ApartadosListScreenState extends ConsumerState<ApartadosListScreen> {
  @override
  Widget build(BuildContext context) {
    final params = const ApartadosQueryParams();
    final apartadosAsync = ref.watch(apartadosListProvider(params));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Apartados'),
      ),
      body: apartadosAsync.when(
        data: (apartados) {
          if (apartados.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No tienes apartados',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: apartados.length,
            itemBuilder: (context, index) {
              final apartado = apartados[index];
              return _buildApartadoCard(apartado);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(apartadosListProvider(params)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApartadoCard(Apartado apartado) {
    final estadoColor = _getEstadoColor(apartado.estado);
    final estadoIcon = _getEstadoIcon(apartado.estado);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(estadoIcon, color: estadoColor),
                const SizedBox(width: 8),
                Text(
                  apartado.estadoTexto,
                  style: TextStyle(
                    color: estadoColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (apartado.expirado)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Expirado',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              apartado.pieza.nombre,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Código: ${apartado.pieza.codigo}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Cantidad: ${apartado.cantidad}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                Text(
                  'Total: \$${(apartado.cantidad * apartado.pieza.precioVenta).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Creado: ${_formatDate(apartado.fechaCreacion)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            if (apartado.fechaExpiracion != null)
              Text(
                'Expira: ${_formatDate(apartado.fechaExpiracion!)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            if (apartado.nota != null) ...[
              const SizedBox(height: 8),
              Text(
                'Nota: ${apartado.nota}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
            if (apartado.puedeCancelar && !apartado.expirado) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmarCancelacion(apartado),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancelar apartado'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getEstadoColor(ApartadoEstado estado) {
    switch (estado) {
      case ApartadoEstado.pendiente:
        return Colors.orange;
      case ApartadoEstado.confirmado:
        return Colors.blue;
      case ApartadoEstado.listoParaRecoger:
        return Colors.green;
      case ApartadoEstado.entregado:
        return Colors.grey;
      case ApartadoEstado.cancelado:
        return Colors.red;
    }
  }

  IconData _getEstadoIcon(ApartadoEstado estado) {
    switch (estado) {
      case ApartadoEstado.pendiente:
        return Icons.pending;
      case ApartadoEstado.confirmado:
        return Icons.check_circle;
      case ApartadoEstado.listoParaRecoger:
        return Icons.shopping_bag;
      case ApartadoEstado.entregado:
        return Icons.done_all;
      case ApartadoEstado.cancelado:
        return Icons.cancel;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _confirmarCancelacion(Apartado apartado) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar apartado'),
        content: Text('¿Estás seguro de cancelar el apartado de ${apartado.pieza.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sí, cancelar'),
          ),
        ],
      ),
    );

    if (confirmado == true && mounted) {
      try {
        await ref.read(apartadosRepositoryProvider).cancelarApartado(apartado.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Apartado cancelado')),
          );
          ref.refresh(apartadosListProvider(const ApartadosQueryParams()));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }
}
