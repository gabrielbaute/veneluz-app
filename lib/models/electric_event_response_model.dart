import 'package:veneluz_app/enums/event_type_enum.dart';
import 'package:veneluz_app/enums/fail_cause_enum.dart';

///Modelo de respuesta de un nuevo evento eléctrico. USado cuando se consulta un evento.
///
/// Attributes:
/// - `id` (String): ID de registro de la falla/evento eléctrico.
/// - `startTimestamp` (DateTime): Marca de tiempo de inicio del evento.
/// - `endTimestamp` (DateTime): Marca de tiempo de finalización del evento.
/// - `latitude` (double): Latitud de la posición desde la que se emitió el registro de evento.
/// - `longitude` (double): Longitud  de la posición desde la que se emitió el registro de evento.
/// - `evenType` (EventType): Tipo de evento, corte o fluctuación.
/// - `failCause` (FailCause): Tipo de causa de la falla/corte.
class ElectricEventResponse {
  final String id;
  final DateTime startTimestamp;
  final DateTime? endTimestamp;
  final double latitude;
  final double longitude;
  final EventType evenType;
  final FailCause failCause;

  ElectricEventResponse({
    required this.id,
    required this.startTimestamp,
    this.endTimestamp,
    required this.latitude,
    required this.longitude,
    required this.evenType,
    required this.failCause,
  });

  /// Convierte un diccionario/map de strings desde la API en un ElectricEventResponse.
  factory ElectricEventResponse.fromJson(Map<String, dynamic> json) {
    return ElectricEventResponse(
      id: json['id'] as String,
      startTimestamp: DateTime.parse(json['start_timestamp'] as String),
      endTimestamp: json['end_timestamp'] != null
          ? DateTime.parse(json['end_timestamp'] as String)
          : null,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      evenType: EventType.parseEventType(json['event_type'] as String),
      failCause: FailCause.parseFailCause(json['fail_cause'] as String),
    );
  }

  /// Convierte el modelo en una respuesta json serializable
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_timestamp': startTimestamp.toIso8601String(),
      'end_timestamp': endTimestamp?.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'event_type': evenType.value,
      'fail_cause': failCause.value,
    };
  }
}
