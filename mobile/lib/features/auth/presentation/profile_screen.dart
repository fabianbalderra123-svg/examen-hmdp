import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(authStateProvider).client;

    if (client == null) {
      return const Scaffold(
        body: Center(child: Text('No hay sesión activa')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mi cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              client.nombre.isNotEmpty ? client.nombre[0].toUpperCase() : 'C',
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            client.nombre,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          _InfoTile(icon: Icons.email, label: 'Email', value: client.email),
          _InfoTile(
            icon: Icons.phone,
            label: 'Teléfono',
            value: client.telefono?.isNotEmpty == true ? client.telefono! : 'Sin registrar',
          ),
          _InfoTile(
            icon: Icons.home,
            label: 'Dirección',
            value: client.direccion?.isNotEmpty == true ? client.direccion! : 'Sin registrar',
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => _confirmarLogout(context, ref),
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmarLogout(BuildContext context, WidgetRef ref) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Quieres salir de tu cuenta?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Salir')),
        ],
      ),
    );
    if (confirmado == true) {
      await ref.read(authStateProvider.notifier).logout();
      if (context.mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
    );
  }
}
