import 'package:flutter/material.dart';

import '../../models/electric_event_response_model.dart';

/// Componente visual encargado de renderizar el mapa de eventos e incidencias eléctricas.
///
/// Attributes:
/// - `events` (List&lt;ElectricEventResponse&gt;): Lista de eventos registrados a desplegar.
class HistoryMapView extends StatelessWidget {
  final List<ElectricEventResponse> events;

  /// Constructor de HistoryMapView.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  /// - `events` (List&lt;ElectricEventResponse&gt;): Lista de eventos eléctricos.
  const HistoryMapView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (events.isEmpty) {
      return Center(
        child: Text(
          'No hay eventos geolocalizados para mostrar',
          style: theme.textTheme.bodyLarge,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.map_rounded,
              size: 64.0,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Mapa de Apagones (${events.length} reportes)',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
