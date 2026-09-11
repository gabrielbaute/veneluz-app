import 'package:flutter/material.dart';

import '../../ui/themes/app_colors.dart';
import '../components/report_action_button.dart';

/// Pantalla principal para el envío de reportes y visualización del estado del servicio.
class ReportScreen extends StatefulWidget {
  /// Constructor de ReportScreen.
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // Simulación temporal de estado de espera/incidencia activa
  bool _hasActiveReport = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_hasActiveReport) {
      return _buildWaitingState(theme);
    }

    return _buildReportPanel(theme);
  }

  /// Construye la interfaz de la botonera para emitir reportes.
  Widget _buildReportPanel(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '¿Cuál es el estado de la energía?',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          ReportActionButton<String, bool>(
            label: 'Reportar Corte',
            icon: Icons.power_off_rounded,
            buttonColor: AppColors.danger,
            payload: 'outage',
            onPressed: (payload) async {
              await Future<void>.delayed(const Duration(seconds: 1));
              return true;
            },
            onSuccess: (_) {
              setState(() {
                _hasActiveReport = true;
              });
            },
          ),
          const SizedBox(height: 12.0),
          ReportActionButton<String, bool>(
            label: 'Reportar Fluctuación',
            icon: Icons.thunderstorm_rounded,
            buttonColor: AppColors.warn,
            payload: 'fluctuation',
            onPressed: (payload) async {
              await Future<void>.delayed(const Duration(seconds: 1));
              return true;
            },
            onSuccess: (_) {
              setState(() {
                _hasActiveReport = true;
              });
            },
          ),
          const SizedBox(height: 12.0),
          ReportActionButton<String, bool>(
            label: 'Servicio Restituido',
            icon: Icons.power_rounded,
            buttonColor: AppColors.ok,
            payload: 'restored',
            onPressed: (payload) async {
              await Future<void>.delayed(const Duration(seconds: 1));
              return true;
            },
          ),
        ],
      ),
    );
  }

  /// Construye la vista de espera cuando hay un reporte en curso.
  Widget _buildWaitingState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(strokeWidth: 3.0),
          const SizedBox(height: 24.0),
          Text('Reporte en proceso', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8.0),
          Text(
            'Estamos registrando la incidencia. Te notificaremos cuando haya novedades en tu zona.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              setState(() {
                _hasActiveReport = false;
              });
            },
            child: const Text('Cancelar / Volver'),
          ),
        ],
      ),
    );
  }
}
