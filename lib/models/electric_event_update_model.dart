import 'package:veneluz_app/enums/event_type_enum.dart';
import 'package:veneluz_app/enums/fail_cause_enum.dart';

///Modelo de actualización de datos de un nuevo evento eléctrico.
///
/// Attributes:
/// - `startTimestamp` (DateTime): Marca de tiempo de inicio del evento.
/// - `endTimestamp` (DateTime): Marca de tiempo de finalización del evento.
/// - `location` (String): Coordenadas desde las que se registró el evento.
/// - `evenType` (EventType): Tipo de evento, corte o fluctuación.
/// - `failCause` (FailCause): Tipo de causa de la falla/corte.
class ElectricEventUpdate {
  final DateTime? startTimestamp;
  final DateTime? endTimestamp;
  final String? location;
  final EventType? evenType;
  final FailCause? failCause;

  ElectricEventUpdate({
    this.startTimestamp,
    this.endTimestamp,
    this.location,
    this.evenType,
    this.failCause,
  });

  /// Convierte el modelo en una respuesta json serializable
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (startTimestamp != null) {
      data['start_timestamp'] = startTimestamp!.toIso8601String();
    }
    if (endTimestamp != null) {
      data['end_timestamp'] = endTimestamp!.toIso8601String();
    }
    if (location != null) {
      data['location'] = location;
    }
    if (evenType != null) {
      data['event_type'] = evenType!.value;
    }
    if (failCause != null) {
      data['fail_cause'] = failCause!.value;
    }

    return data;
  }
}
