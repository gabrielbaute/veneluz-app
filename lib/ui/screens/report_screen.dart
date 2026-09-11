import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/event_type_enum.dart';
import '../../enums/fail_cause_enum.dart';
import '../../providers/electric_event_provider.dart';
import '../components/report_action_button.dart';
import '../themes/app_colors.dart';

/// Pantalla principal para el envío de reportes y visualización del estado del servicio eléctrico.
class ReportScreen extends StatefulWidget {
  /// Constructor de ReportScreen.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final FailCause _selectedCause = FailCause.desconocida;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventProvider = context.watch<ElectricEventProvider>();

    if (eventProvider.hasActiveEvent) {
      return _buildWaitingState(context, theme, eventProvider);
    }

    return _buildReportPanel(context, theme, eventProvider);
  }

  /// Construye la botonera principal para la emisión de nuevos reportes eléctricos.
  ///
  /// Args:
  /// - `context` (BuildContext): Contexto de la aplicación.
  /// - `theme` (ThemeData): Configuración del tema actual.
  /// - `provider` (ElectricEventProvider): Instancia del provider de eventos eléctricos.
  ///
  /// Returns:
  /// - `Widget`: Contenedor con los botones de acción rápida.
  Widget _buildReportPanel(
    BuildContext context,
    ThemeData theme,
    ElectricEventProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '¿Cuál es el estado del servicio eléctrico?',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          ReportActionButton<EventType, bool>(
            label: 'Reportar Corte Total',
            icon: Icons.power_off_rounded,
            buttonColor: AppColors.danger,
            payload: EventType.corte,
            isLoading: provider.isLoading,
            onPressed: (payload) => provider.reportNewEvent(
              eventType: payload,
              failCause: _selectedCause,
            ),
            onError: (error) => _showSnackBar(context, provider.errorMessage),
          ),
          const SizedBox(height: 12.0),
          ReportActionButton<EventType, bool>(
            label: 'Reportar Caída de Tensión',
            icon: Icons.thunderstorm_rounded,
            buttonColor: AppColors.warn,
            payload: EventType.caidaTension,
            isLoading: provider.isLoading,
            onPressed: (payload) => provider.reportNewEvent(
              eventType: payload,
              failCause: _selectedCause,
            ),
            onError: (error) => _showSnackBar(context, provider.errorMessage),
          ),
          const SizedBox(height: 12.0),
          ReportActionButton<EventType, bool>(
            label: 'Reportar Fluctuación',
            icon: Icons.bolt_rounded,
            buttonColor: AppColors.info,
            payload: EventType.fluctuacion,
            isLoading: provider.isLoading,
            onPressed: (payload) => provider.reportNewEvent(
              eventType: payload,
              failCause: _selectedCause,
            ),
            onError: (error) => _showSnackBar(context, provider.errorMessage),
          ),
        ],
      ),
    );
  }

  /// Construye la vista de espera y monitoreo cuando un evento de corte o caída permanece activo.
  ///
  /// Args:
  /// - `context` (BuildContext): Contexto de la aplicación.
  /// - `theme` (ThemeData): Configuración del tema actual.
  /// - `provider` (ElectricEventProvider): Instancia del provider de eventos eléctricos.
  ///
  /// Returns:
  /// - `Widget`: Vista informativa con botón para la restitución del servicio.
  Widget _buildWaitingState(
    BuildContext context,
    ThemeData theme,
    ElectricEventProvider provider,
  ) {
    final activeEvent = provider.activeEvent;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(strokeWidth: 3.0),
          const SizedBox(height: 24.0),
          Text('Sin Servicio Eléctrico', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8.0),
          Text(
            'Iniciado: ${activeEvent?.startTimestamp.toLocal().toString().split('.').first ?? ''}',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          ReportActionButton<void, bool>(
            label: 'Servicio Restituido',
            icon: Icons.power_rounded,
            buttonColor: AppColors.ok,
            payload: null,
            isLoading: provider.isLoading,
            onPressed: (_) => provider.finalizeActiveEvent(),
            onError: (error) => _showSnackBar(context, provider.errorMessage),
          ),
        ],
      ),
    );
  }

  /// Muestra una barra flotante con el mensaje de error capturado.
  ///
  /// Args:
  /// - `context` (BuildContext): Contexto para desplegar el SnackBar.
  /// - `message` (String?): Texto del mensaje de error.
  void _showSnackBar(BuildContext context, String? message) {
    if (message == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
