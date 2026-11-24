import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/apartado.dart';
import '../domain/apartados_provider.dart';

class ApartadosListScreen extends ConsumerWidget {
  final bool embedded;

  const ApartadosListScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const params = ApartadosQueryParams();
    final apartadosAsync = ref.watch(apartadosListProvider(params));

    final body = apartadosAsync.when(
      data: (apartados) {
        if (apartados.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Aún no tienes apartados', style: TextStyle(fontSize: 18, color: Colors.grey)),
                SizedBox(height: 8),
                Text('Elige una pieza en el catálogo para reservarla'),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(apartadosListProvider(params));
            await ref.read(apartadosListProvider(params).future);
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16, top: 8),
            itemCount: apartados.length,
            itemBuilder: (context, index) => _ApartadoCard(apartado: apartados[index]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(error.toString().replaceFirst('Exception: ', ''), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(apartadosListProvider(params)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );

    if (embedded) return body;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis apartados')),
      body: body,
    );
  }
}

class _ApartadoCard extends ConsumerWidget {
  final Apartado apartado;

  const _ApartadoCard({required this.apartado});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoColor = _estadoColor(apartado.estado);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_estadoIcon(apartado.estado), color: estadoColor),
                const SizedBox(width: 8),
                Text(
                  apartado.estadoTexto,
                  style: TextStyle(color: estadoColor, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (apartado.pendingSync)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Por enviar',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                else if (apartado.expirado)
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Código: ${apartado.pieza.codigo}', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(
              'Cantidad: ${apartado.cantidad}  ·  Total: \$${(apartado.cantidad * apartado.pieza.precioVenta).toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text('Creado: ${_formatDate(apartado.fechaCreacion)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            if (apartado.fechaExpiracion != null)
              Text('Expira: ${_formatDate(apartado.fechaExpiracion!)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            if (apartado.nota != null) ...[
              const SizedBox(height: 8),
              Text('Nota: ${apartado.nota}', style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
            if ((apartado.puedeCancelar && !apartado.expirado) || apartado.pendingSync) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmarCancelacion(context, ref),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancelar apartado'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirmarCancelacion(BuildContext context, WidgetRef ref) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar apartado'),
        content: Text('¿Cancelar el apartado de ${apartado.pieza.nombre}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sí, cancelar')),
        ],
      ),
    );

    if (confirmado != true || !context.mounted) return;
    try {
      await ref.read(apartadosRepositoryProvider).cancelarApartado(apartado.id);
      ref.invalidate(apartadosListProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Apartado cancelado')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    }
  }
}

Color _estadoColor(ApartadoEstado estado) {
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

IconData _estadoIcon(ApartadoEstado estado) {
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
  final local = date.toLocal();
  return '${local.day}/${local.month}/${local.year} ${local.hour}:${local.minute.toString().padLeft(2, '0')}';
}
