/// Clase para manejo de las rutas de conexión a la API
/// Inyecta baseUrl como variable de entorno.
class ApiEndpoints {
  // Constructor. Previene la instanciación.
  ApiEndpoints._();

  // --- Base URL ---
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://veneluz.samanbooks.site',
  );

  // --- Health / Server info ---
  static const String healthCheck = '/api/v1/health';

  // --- Electric Events ---
  static const String registerEvent = '/api/v1/events/register';
  static const String updateEvent = '/api/v1/events';
  static const String getEvent = '/api/v1/events/';
  static const String getHistoryEvents = '/api/v1/events/history';
}
