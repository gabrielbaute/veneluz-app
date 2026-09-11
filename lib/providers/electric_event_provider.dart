import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../enums/event_type_enum.dart';
import '../enums/fail_cause_enum.dart';
import '../errors/api_exceptions.dart';
import '../models/electric_event_create_model.dart';
import '../models/electric_event_list_response_model.dart';
import '../models/electric_event_response_model.dart';
import '../models/electric_event_update_model.dart';
import '../services/electric_events_service.dart';
import '../services/location_service.dart';

/// Provider de estado de la aplicación para gestionar la creación, actualización y consulta de eventos eléctricos.
///
/// Attributes:
/// - `_electricEventsService` (ElectricEventsService): Servicio de consulta y registro de eventos eléctricos.
/// - `_locationService` (LocationService): Servicio interno para proveer la ubicación del dispositivo en el momento del registro de un evento eléctrico.
/// - `_uuid` (const): Identificador del evento eléctrico registrado en la app.
/// - `_activeEvent` (ElectricEventResponse?): Contenedor del registro de un evento eléctrico generado en la app.
/// - `_eventsHistory` (ElectricEventListResponse): Contenedor de consulta de histórico de eventos eléctricos.
/// - `_isLoading` (bool): Estado que indica si la carga de históricos está en proceso.
/// - `_errorMessage` (String?): Mensaje de error en caso de fallo en la petición.
class ElectricEventProvider extends ChangeNotifier {
  final ElectricEventsService _electricEventsService;
  final LocationService _locationService;
  static const _uuid = Uuid();

  ElectricEventResponse? _activeEvent;
  ElectricEventListResponse _eventsHistory = ElectricEventListResponse();

  bool _isLoading = false;
  String? _errorMessage;

  ElectricEventProvider({
    ElectricEventsService? electricEventsService,
    LocationService? locationService,
  }) : _electricEventsService =
           electricEventsService ?? ElectricEventsService(),
       _locationService = locationService ?? LocationService();

  // --- Getters de Estado ---
  ElectricEventResponse? get activeEvent => _activeEvent;
  ElectricEventListResponse get eventsHistory => _eventsHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasActiveEvent => _activeEvent != null;

  /// Registra un nuevo evento eléctrico desde la botonera inicial.
  ///
  /// Args:
  /// - `eventType` (EventType): Tipo de evento a reportar (CORTE, CAIDA_TENSION, FLUCTUACION).
  /// - `failCause` (FailCause): Causa de la falla si aplica.
  ///
  /// Returns:
  /// - `Future<bool>`: `true` si la operación en backend fue exitosa, `false` en caso contrario.
  Future<bool> reportNewEvent({
    required EventType eventType,
    FailCause failCause = FailCause.desconocida,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final position = await _locationService.getCurrentLocation();
      final now = DateTime.now();

      final createModel = ElectricEventCreate(
        id: _uuid.v4(),
        startTimestamp: now,
        endTimestamp: eventType == EventType.fluctuacion ? now : null,
        latitude: position?.latitude ?? 0.0,
        longitude: position?.longitude ?? 0.0,
        evenType: eventType,
        failCause: failCause,
      );

      final response = await _electricEventsService.registerElectricEvent(
        eventData: createModel,
      );

      if (response != null) {
        if (eventType != EventType.fluctuacion) {
          _activeEvent = response;
        }
        _setLoading(false);
        return true;
      }
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Error inesperado al reportar el evento: $e';
    }

    _setLoading(false);
    return false;
  }

  /// Finaliza o actualiza un evento activo cambiando sus parámetros o cerrándolo.
  ///
  /// Args:
  /// - `newType` (EventType?): Nuevo tipo de evento si el usuario decide redefinirlo.
  /// - `newCause` (FailCause?): Nueva causa seleccionada.
  ///
  /// Returns:
  /// - `Future<bool>`: `true` si la actualización fue exitosa, `false` en caso contrario.
  Future<bool> finalizeActiveEvent({
    EventType? newType,
    FailCause? newCause,
  }) async {
    if (_activeEvent == null) return false;

    _setLoading(true);
    _clearError();

    try {
      final position = await _locationService.getCurrentLocation();

      final updateModel = ElectricEventUpdate(
        endTimestamp: DateTime.now(),
        latitude: position?.latitude,
        longitude: position?.longitude,
        evenType: newType,
        failCause: newCause,
      );

      final response = await _electricEventsService.updateElectricEvent(
        id: _activeEvent!.id,
        eventData: updateModel,
      );

      if (response != null) {
        _activeEvent = null;
        _setLoading(false);
        return true;
      }
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Error al actualizar el evento: $e';
    }

    _setLoading(false);
    return false;
  }

  /// Carga el historial de eventos registrados desde el servidor.
  ///
  /// Args:
  /// - `startDate` (DateTime): Fecha inicial del rango.
  /// - `endDate` (DateTime): Fecha final del rango.
  Future<void> fetchEventsHistory({
    required DateTime startDate,
    required DateTime endDate,
    int skip = 0,
    int limit = 100,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _eventsHistory = await _electricEventsService.getHistoryEvents(
        startDate: startDate,
        endDate: endDate,
        skip: skip,
        limit: limit,
      );
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Error al cargar el historial: $e';
    }

    _setLoading(false);
  }

  /// Limpia la caché local del historial y reinicia mensajes de error.
  void clearCache({bool clearActiveEvent = false}) {
    _eventsHistory = ElectricEventListResponse();
    _errorMessage = null;

    if (clearActiveEvent) {
      _activeEvent = null;
    }

    notifyListeners();
  }

  /// Descarta el evento activo localmente sin realizar peticiones de red.
  void resetActiveEvent() {
    _activeEvent = null;
    notifyListeners();
  }

  // --- Métodos Auxiliares Privados ---
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
