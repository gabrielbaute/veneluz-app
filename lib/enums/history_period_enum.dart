/// Opciones predefinidas de periodo de tiempo para la consulta del historial.
///
/// Attributes:
/// - `day1`: 24 horas
/// - `days3`: 3 días
/// - `days7`: 7 días
/// - `days15`: 15 días
/// - `days30`: 30 días
enum HistoryPeriod {
  day1(1, '24 horas'),
  days3(3, '3 días'),
  days7(7, '7 días'),
  days15(15, '15 días'),
  days30(30, '30 días');

  final int days;
  final String label;

  const HistoryPeriod(this.days, this.label);
}
