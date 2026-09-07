///Tipo de corte eléctrico en función de su causa.
///
/// - `falla`: Corte por falla eléctrica local o regional, no intencional.
/// - `racionamiento`: Corte eléctrico por racionamiento.
/// - `mantenimiento`: Para realizar algún mantenimiento local o regional.
/// - `desconocida`: Se desconoce el motivo del corte eléctrico.
/// - `noAplica`: Cuando no se trata de un corte sino de una fluctuación.
enum FailCause {
  falla('FALLA'),
  racionamiento('RACIONAMIENTO'),
  mantenimiento('MANTENIMIENTO'),
  desconocida('DESCONOCIDA'),
  noAplica('NO_APLICA');

  final String value;
  const FailCause(this.value);
}
