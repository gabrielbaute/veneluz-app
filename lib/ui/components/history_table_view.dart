import 'package:flutter/material.dart';

import '../../models/electric_event_response_model.dart';

/// Componente visual que despliega el registro histórico de eventos eléctricos en formato tabular.
///
/// Attributes:
/// - `events` (List&lt;ElectricEventResponse&gt;): Lista de eventos registrados.
class HistoryTableView extends StatelessWidget {
  final List<ElectricEventResponse> events;

  /// Constructor de HistoryTableView.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  /// - `events` (List&lt;ElectricEventResponse&gt;): Lista de eventos eléctricos.
  const HistoryTableView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (events.isEmpty) {
      return Center(
        child: Text(
          'No hay registros históricos en la última semana',
          style: theme.textTheme.bodyLarge,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            theme.colorScheme.surfaceContainerHighest,
          ),
          columns: const <DataColumn>[
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Causa')),
            DataColumn(label: Text('Inicio')),
            DataColumn(label: Text('Fin')),
            DataColumn(label: Text('Duración')),
          ],
          rows: events.map((ElectricEventResponse event) {
            final String durationText = event.endTimestamp != null
                ? '${event.endTimestamp!.difference(event.startTimestamp).inMinutes} min'
                : 'En curso';

            return DataRow(
              cells: <DataCell>[
                DataCell(Text(event.evenType.name)),
                DataCell(Text(event.failCause.name)),
                DataCell(
                  Text(
                    event.startTimestamp.toLocal().toString().split('.').first,
                  ),
                ),
                DataCell(
                  Text(
                    event.endTimestamp?.toLocal().toString().split('.').first ??
                        '-',
                  ),
                ),
                DataCell(Text(durationText)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
