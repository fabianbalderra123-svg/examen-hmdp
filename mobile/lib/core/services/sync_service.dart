import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/apartados/data/apartados_repository.dart';
import '../../features/apartados/domain/apartados_provider.dart';
import '../providers/connectivity_provider.dart';
import 'local_database.dart';

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
        await _localDatabase.deleteApartado(apartado.id);
      } catch (_) {
        // Se reintenta en la siguiente reconexión.
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
  final Ref _ref;

  SyncNotifier(this._syncService, this._ref) : super(SyncState.idle()) {
    _startSyncListener();
  }

  void _startSyncListener() {
    _ref.listen(connectivityProvider, (previous, next) {
      next.whenData((status) {
        if (status == ConnectivityStatus.online) {
          sync();
        }
      });
    });
  }

  Future<void> sync() async {
    if (state.isSyncing) return;

    state = SyncState.syncing();
    try {
      await _syncService.syncPendingApartados();
      _ref.invalidate(apartadosListProvider);
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
