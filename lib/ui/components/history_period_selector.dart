import 'package:flutter/material.dart';

import '../../enums/history_period_enum.dart';

/// Componente para seleccionar la ventana temporal de consulta de historial.
///
/// Attributes:
/// - `selectedPeriod` (HistoryPeriod): Periodo actualmente seleccionado.
/// - `onPeriodChanged` (ValueChanged<HistoryPeriod>): Callback emitido al cambiar la selección.
class HistoryPeriodSelector extends StatelessWidget {
  final HistoryPeriod selectedPeriod;
  final ValueChanged<HistoryPeriod> onPeriodChanged;

  /// Constructor de HistoryPeriodSelector.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  /// - `selectedPeriod` (HistoryPeriod): Periodo seleccionado actual.
  /// - `onPeriodChanged` (ValueChanged<HistoryPeriod>): Función callback ejecutada tras la selección.
  const HistoryPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: HistoryPeriod.values.map((HistoryPeriod period) {
          final bool isSelected = period == selectedPeriod;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(period.label),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onPeriodChanged(period);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
