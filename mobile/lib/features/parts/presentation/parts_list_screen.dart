import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/part.dart';
import '../domain/parts_provider.dart';
import 'part_detail_screen.dart';

class PartsListScreen extends ConsumerStatefulWidget {
  final bool embedded;

  const PartsListScreen({super.key, this.embedded = false});

  @override
  ConsumerState<PartsListScreen> createState() => _PartsListScreenState();
}

class _PartsListScreenState extends ConsumerState<PartsListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      setState(() => _searchQuery = value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final params = PartsQueryParams(
      search: _searchQuery.isEmpty ? null : _searchQuery,
    );
    final partsAsync = ref.watch(partsListProvider(params));

    final body = Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, código o marca',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
            ),
            onChanged: _onSearchChanged,
          ),
        ),
        Expanded(
          child: partsAsync.when(
            data: (parts) {
              if (parts.isEmpty) {
                return const Center(child: Text('No se encontraron refacciones'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(partsListProvider(params));
                  await ref.read(partsListProvider(params).future);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: parts.length,
                  itemBuilder: (context, index) => _PartCard(part: parts[index]),
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
                    Text(
                      error.toString().replaceFirst('Exception: ', ''),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => ref.invalidate(partsListProvider(params)),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (widget.embedded) return body;

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: body,
    );
  }
}

class _PartCard extends StatelessWidget {
  final Part part;

  const _PartCard({required this.part});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(part.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${part.codigo}${part.marca != null ? ' · ${part.marca}' : ''}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '\$${part.precioVenta.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  part.stock > 0 ? 'Disponible (${part.stock})' : 'Agotado',
                  style: TextStyle(
                    color: part.stock > 0 ? Colors.green[800] : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PartDetailScreen(part: part)),
          );
        },
      ),
    );
  }
}
