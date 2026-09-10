import '../models/electric_event_create_model.dart';
import '../models/electric_event_list_response_model.dart';
import '../models/electric_event_response_model.dart';
import '../models/electric_event_update_model.dart';
import 'api_client_service.dart';
import 'api_endpoints.dart';

/// Servicio de registro y consulta de eventos eléctricos en la aplicación.
class ElectricEventsService {
  final ApiClient _apiClient;

  ElectricEventsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  ///Registra un evento eléctrico en el servidor y devuelve los datos del evento registrado.
  ///
  /// Args:
  /// - `eventData` (ElectricEventCreate): Esquema de registro de evento con los datos del evento eléctrico.
  ///
  /// Returns:
  /// - `ElectricEventResponse`: Esquema de respuesta del evento eléctrico registrado.
  Future<ElectricEventResponse?> registerElectricEvent({
    required ElectricEventCreate eventData,
  }) async {
    final responseData = await _apiClient.post(
      ApiEndpoints.registerEvent,
      data: eventData.toJson(),
    );
    if (responseData == null) return null;
    return ElectricEventResponse.fromJson(responseData);
  }

  ///Actualiza un evento eléctrico en el servidor y devuelve los datos del evento.
  ///
  /// Args:
  /// - `id`: ID del evento en la base de datos.
  /// - `eventData` (ElectricEventUpdate): Esquema de registro de evento con los datos del evento eléctrico.
  ///
  /// Returns:
  /// - `ElectricEventResponse`: Esquema de respuesta del evento eléctrico.
  Future<ElectricEventResponse?> updateElectricEvent({
    required String id,
    required ElectricEventUpdate eventData,
  }) async {
    final responseData = await _apiClient.put(
      ApiEndpoints.updateEvent,
      queryParameters: {'event_id ': id},
    );
    if (responseData.isEmpty) {
      return null;
    }
    return ElectricEventResponse.fromJson(responseData);
  }

  ///Obtiene los datos de un evento eléctrico a partir de su ID.
  ///
  /// Args:
  /// - `id`: ID del evento en la base de datos.
  ///
  /// Returns:
  /// - `ElectricEventResponse`: Esquema de respuesta del evento eléctrico.
  Future<ElectricEventResponse?> getEventByID({required String id}) async {
    final responseData = await _apiClient.get(
      ApiEndpoints.getEvent,
      queryParameters: {'event_id': id},
    );
    if (responseData.isEmpty) {
      return null;
    }
    return ElectricEventResponse.fromJson(responseData);
  }

  ///Obtiene el histórico de eventos eléctricos registrados en el servidor.
  ///
  /// Args:
  /// - `startDate` (DateTime): Fecha de inicio, desde dónde se quieren traer los registros.
  /// - `endDate` (DateTime): Fecha de fin: hasta quié fecha se debe traer los registros.
  /// - `skip` (int): Número de registros a saltar (paginación).
  /// - `limit` (int): Número máximo de registros a retornar.
  ///
  /// Returns:
  /// - `ElectricEventListResponse`: Esquema de respuesta en lista con el conteo de registros y una lsita de `ElectricEventResponse`.
  Future<ElectricEventListResponse> getHistoryEvents({
    required DateTime startDate,
    required DateTime endDate,
    int skip = 0,
    int limit = 100,
  }) async {
    final responseData = await _apiClient.get(
      ApiEndpoints.getHistoryEvents,
      queryParameters: {
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'skip': skip,
        'limit': limit,
      },
    );
    return ElectricEventListResponse.fromJson(responseData);
  }
}
