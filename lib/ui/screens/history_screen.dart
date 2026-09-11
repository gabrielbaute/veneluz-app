import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/history_period_enum.dart';
import '../../providers/electric_event_provider.dart';
import '../components/history_map_view.dart';
import '../components/history_period_selector.dart';
import '../components/history_table_view.dart';

/// Pantalla encargada de gestionar y listar el historial de eventos eléctricos.
///
/// Permite conmutar entre vista de mapa/tabla y filtrar por el periodo temporal seleccionado.
class HistoryScreen extends StatefulWidget {
  /// Constructor de HistoryScreen.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  /// Define la vista activa actual (0: Mapa, 1: Tabla).
  int _selectedViewIndex = 0;

  /// Periodo de historial seleccionado por defecto (7 días).
  HistoryPeriod _selectedPeriod = HistoryPeriod.days7;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHistory();
    });
  }

  /// Carga el historial dinámicamente según el [HistoryPeriod] seleccionado.
  Future<void> _loadHistory() async {
    final DateTime now = DateTime.now();
    final DateTime startDate = now.subtract(
      Duration(days: _selectedPeriod.days),
    );

    await context.read<ElectricEventProvider>().fetchEventsHistory(
      startDate: startDate,
      endDate: now,
    );
  }

  /// Cambia el periodo seleccionado y recalcula la petición.
  void _onPeriodChanged(HistoryPeriod newPeriod) {
    if (_selectedPeriod != newPeriod) {
      setState(() {
        _selectedPeriod = newPeriod;
      });
      _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Incidencias'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Recargar',
            onPressed: _loadHistory,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 8.0),
          HistoryPeriodSelector(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: _onPeriodChanged,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SegmentedButton<int>(
              segments: const <ButtonSegment<int>>[
                ButtonSegment<int>(
                  value: 0,
                  label: Text('Mapa'),
                  icon: Icon(Icons.map_outlined),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Text('Tabla'),
                  icon: Icon(Icons.table_chart_outlined),
                ),
              ],
              selected: <int>{_selectedViewIndex},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  _selectedViewIndex = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: Consumer<ElectricEventProvider>(
              builder:
                  (
                    BuildContext context,
                    ElectricEventProvider provider,
                    Widget? child,
                  ) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.errorMessage != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error_outline_rounded,
                                size: 48.0,
                                color: theme.colorScheme.error,
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                'Ocurrió un error al cargar el historial',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                provider.errorMessage!,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 16.0),
                              FilledButton.icon(
                                onPressed: _loadHistory,
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final eventsList = provider.eventsHistory.events;

                    if (_selectedViewIndex == 0) {
                      return HistoryMapView(events: eventsList);
                    }

                    return HistoryTableView(events: eventsList);
                  },
            ),
          ),
        ],
      ),
    );
  }
}
