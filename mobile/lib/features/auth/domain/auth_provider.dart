import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiServiceProvider));
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.checking()) {
    restoreSession();
  }

  Future<void> restoreSession() async {
    state = AuthState.checking();
    final hasToken = await _repository.apiService.isAuthenticated();
    if (!hasToken) {
      state = AuthState.unauthenticated();
      return;
    }
    try {
      final client = await _repository.getMe();
      state = AuthState.authenticated(client);
    } on AuthException catch (e) {
      if (e.unauthorized) {
        await _repository.logout();
        state = AuthState.unauthenticated();
        return;
      }
      state = AuthState.unauthenticated();
    } catch (_) {
      final cached = await _repository.getCachedClient();
      if (cached != null) {
        state = AuthState.authenticated(cached);
      } else {
        await _repository.logout();
        state = AuthState.unauthenticated();
      }
    }
  }

  Future<void> register({
    required String nombre,
    required String email,
    required String password,
    String? telefono,
    String? direccion,
  }) async {
    state = AuthState.loading();
    try {
      final data = await _repository.register(
        nombre: nombre,
        email: email,
        password: password,
        telefono: telefono,
        direccion: direccion,
      );
      final client = Client.fromJson(data['client']);
      state = AuthState.authenticated(client);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();
    try {
      final data = await _repository.login(email: email, password: password);
      final client = Client.fromJson(data['client']);
      state = AuthState.authenticated(client);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState.unauthenticated();
  }
}

class AuthState {
  final bool isLoading;
  final bool isChecking;
  final Client? client;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isChecking = false,
    this.client,
    this.error,
  });

  factory AuthState.checking() => AuthState(isChecking: true);

  factory AuthState.loading() => AuthState(isLoading: true);

  factory AuthState.authenticated(Client client) =>
      AuthState(client: client);

  factory AuthState.unauthenticated() => AuthState();

  factory AuthState.error(String error) => AuthState(error: error);

  bool get isAuthenticated => client != null;
}
