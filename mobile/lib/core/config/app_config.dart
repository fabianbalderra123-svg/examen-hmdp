class AppConfig {
  static const String baseUrlDev = 'http://localhost:4000';
  static const String baseUrlProd = 'https://backexamen1-herramientas.onrender.com';

  static String get baseUrl {
    const bool isProd = bool.fromEnvironment('dart.vm.product');
    return isProd ? baseUrlProd : baseUrlDev;
  }

  static const Duration apiTimeout = Duration(seconds: 60);

  static const String apiPath = '/api';
}
