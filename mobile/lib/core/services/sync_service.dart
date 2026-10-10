import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/services/local_database.dart';
import '../../apartados/data/apartados_repository.dart';

class SyncService {
  final ApartadosRepository _apartadosRepository;
  final LocalDatabase _localDatabase;

  SyncService(this._apartadosRepository, this._localDatabase);

  Future<void> syncPendingApartados() async {
    final pending = await _localDatabase.getPendingApartados();

    for (final apartado in pending) {
      try {
        await _apartadosRepository.createApartado(
          piezaId: apartado.piezaId,
          cantidad: apartado.cantidad,
          nota: apartado.nota,
        );
        await _localDatabase.markAsSynced(apartado.id);
      } catch (e) {
        print('Error sincronizando apartado ${apartado.id}: $e');
      }
    }
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final apartadosRepo = ref.watch(apartadosRepositoryProvider);
  final localDb = LocalDatabase.instance;
  return SyncService(apartadosRepo, localDb);
});

class SyncNotifier extends StateNotifier<SyncState> {
  final SyncService _syncService;
  Timer? _syncTimer;

  SyncNotifier(this._syncService, Ref ref) : super(SyncState.idle()) {
    _startSyncListener(ref);
  }

  void _startSyncListener(Ref ref) {
    ref.listen<ConnectivityStatus>(
      connectivityProvider,
      (previous, next) {
        if (next == ConnectivityStatus.online) {
          sync();
        }
      },
    );
  }

  Future<void> sync() async {
    if (state.isSyncing) return;

    state = SyncState.syncing();
    try {
      await _syncService.syncPendingApartados();
      state = SyncState.success();
    } catch (e) {
      state = SyncState.error(e.toString());
    }
  }
}

class SyncState {
  final bool isSyncing;
  final String? error;
  final DateTime? lastSync;

  SyncState({
    this.isSyncing = false,
    this.error,
    this.lastSync,
  });

  factory SyncState.idle() => SyncState();

  factory SyncState.syncing() => SyncState(isSyncing: true);

  factory SyncState.success() => SyncState(lastSync: DateTime.now());

  factory SyncState.error(String error) => SyncState(error: error);
}

final syncStateProvider = StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  return SyncNotifier(ref.watch(syncServiceProvider), ref);
});
