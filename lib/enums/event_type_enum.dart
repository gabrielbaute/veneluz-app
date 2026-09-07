/// Enum para los tipos de eventos eléctricos
///
/// - `corte`: Corte eléctrico.
/// - `caidaTension`: Caída de la tensión eléctrica en la red, sin que la electricidad se corte por completo.
/// - `fluctuacion`: Fluctuación o pico en la red eléctrica.
enum EventType {
  corte('CORTE'),
  caidaTension('CAIDA_TENSION'),
  fluctuacion('FLUCTUACION');

  final String value;
  const EventType(this.value);

  /// Método para parsear valores strings a EventType
  ///
  /// Args:
  /// - `value` (String): tipo de evento escrito como string.
  ///
  /// Returns:
  /// - `EventType`
  static EventType parseEventType(String value) {
    return EventType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw FormatException('Invalid EventType: $value'),
    );
  }
}
