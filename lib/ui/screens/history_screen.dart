import 'package:flutter/material.dart';

/// Pantalla encargada de listar el historial de reportes realizados.
class HistoryScreen extends StatelessWidget {
  /// Constructor de HistoryScreen.
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.bolt_rounded, color: theme.colorScheme.primary),
            title: Text(
              'Reporte #${1000 + index}',
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              'Registrado el 11/09/2026',
              style: theme.textTheme.bodySmall,
            ),
            trailing: Text(
              'Procesado',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );
  }
}
