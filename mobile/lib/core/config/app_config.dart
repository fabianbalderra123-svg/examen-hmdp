class AppConfig {
  static const String baseUrlProd =
      'https://backexamen1-herramientas.onrender.com';

  /// Override with: --dart-define=API_URL=https://...
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: baseUrlProd,
  );

  static const Duration apiTimeout = Duration(seconds: 60);

  static const String apiPath = '/api';
}
