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
}
