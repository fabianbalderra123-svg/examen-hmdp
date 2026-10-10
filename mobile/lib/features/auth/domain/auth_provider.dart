import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/client.dart';
import '../../../core/services/api_service.dart';
import '../data/auth_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiServiceProvider));
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isAuthenticated = await _repository._apiService.isAuthenticated();
    if (isAuthenticated && state.client == null) {
      try {
        final client = await _repository.getMe();
        state = AuthState.authenticated(client);
      } catch (_) {
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
  final Client? client;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.client,
    this.error,
  });

  factory AuthState.initial() => AuthState();

  factory AuthState.loading() => AuthState(isLoading: true);

  factory AuthState.authenticated(Client client) =>
      AuthState(client: client);

  factory AuthState.unauthenticated() => AuthState();

  factory AuthState.error(String error) => AuthState(error: error);

  bool get isAuthenticated => client != null;
}
