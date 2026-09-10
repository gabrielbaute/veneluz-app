import 'package:veneluz_app/enums/event_type_enum.dart';
import 'package:veneluz_app/enums/fail_cause_enum.dart';

///Modelo de registro de un nuevo evento eléctrico.
///
/// Attributes:
/// - `id` (String): ID de registro de la falla/evento eléctrico.
/// - `startTimestamp` (DateTime): Marca de tiempo de inicio del evento.
/// - `endTimestamp` (DateTime): Marca de tiempo de finalización del evento.
/// - `latitude` (double): Latitud de la posición desde la que se emitió el registro de evento.
/// - `longitude` (double): Longitud  de la posición desde la que se emitió el registro de evento.
/// - `evenType` (EventType): Tipo de evento, corte o fluctuación.
/// - `failCause` (FailCause): Tipo de causa de la falla/corte.
class ElectricEventCreate {
  final String id;
  final DateTime startTimestamp;
  final DateTime? endTimestamp;
  final double latitude;
  final double longitude;
  final EventType evenType;
  final FailCause failCause;

  ElectricEventCreate({
    required this.id,
    required this.startTimestamp,
    this.endTimestamp,
    required this.latitude,
    required this.longitude,
    required this.evenType,
    required this.failCause,
  });

  /// Convierte el modelo en una respuesta json serializable
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_timestamp': startTimestamp,
      'end_timestamp': endTimestamp,
      'latitude': latitude,
      'longitude': longitude,
      'event_type': evenType.value,
      'fail_cause': failCause.value,
    };
  }
}
