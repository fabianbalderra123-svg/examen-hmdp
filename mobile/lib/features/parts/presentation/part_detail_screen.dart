import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/part.dart';
import '../../apartados/domain/apartados_provider.dart';

class PartDetailScreen extends ConsumerStatefulWidget {
  final Part part;

  const PartDetailScreen({super.key, required this.part});

  @override
  ConsumerState<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends ConsumerState<PartDetailScreen> {
  int _cantidad = 1;
  final _notaController = TextEditingController();
  bool _enviando = false;

  Part get part => widget.part;

  @override
  void dispose() {
    _notaController.dispose();
    super.dispose();
  }

  Future<void> _apartar() async {
    if (part.stock <= 0) return;
    setState(() => _enviando = true);
    try {
      final creado = await ref.read(apartadosRepositoryProvider).createApartado(
            piezaId: part.id,
            cantidad: _cantidad,
            nota: _notaController.text.trim().isEmpty
                ? null
                : _notaController.text.trim(),
            pieza: part,
          );
      ref.invalidate(apartadosListProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            creado.pendingSync
                ? 'Sin conexión. El apartado se enviará al reconectar.'
                : 'Pieza apartada. Recógela en sucursal.',
          ),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sinStock = part.stock <= 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            part.nombre,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text('Código: ${part.codigo}', style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (part.categoria != null) Chip(label: Text(part.categoria!)),
              if (part.marca != null) Chip(label: Text(part.marca!)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precio', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                    Text(
                      '\$${part.precioVenta.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Disponibles', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                    Text(
                      '${part.stock}',
                      style: TextStyle(
                        color: sinStock ? Colors.red : Colors.green[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (part.descripcion != null && part.descripcion!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Descripción', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(part.descripcion!),
          ],
          const SizedBox(height: 24),
          Text('Apartar para recoger en tienda',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'El apartado caduca en 48 horas. El inventario se confirma en sucursal.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Cantidad', style: TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              IconButton.filledTonal(
                onPressed: _cantidad > 1 ? () => setState(() => _cantidad--) : null,
                icon: const Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('$_cantidad', style: theme.textTheme.titleLarge),
              ),
              IconButton.filledTonal(
                onPressed: !sinStock && _cantidad < part.stock
                    ? () => setState(() => _cantidad++)
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notaController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Nota (opcional)',
              hintText: 'Ej. recoger mañana por la tarde',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total: \$${(part.precioVenta * _cantidad).toStringAsFixed(2)}',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: sinStock || _enviando ? null : _apartar,
            icon: _enviando
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.bookmark_add),
            label: Text(sinStock ? 'Sin stock' : 'Apartar pieza'),
          ),
        ],
      ),
    );
  }
}
