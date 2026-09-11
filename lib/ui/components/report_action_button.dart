import 'package:flutter/material.dart';

/// Callback genérico para procesar la acción de envío de un reporte.
typedef ReportActionCallback<TRequest, TResponse> = Future<TResponse> Function(
  TRequest requestData,
);

/// Widget genérico para botones de acción rápida de reportes (Corte, Fluctuación, Restitución, etc.).
///
/// Attributes:
/// - `label` (String): Texto visible del botón.
/// - `icon` (IconData): Ícono representativo de la acción.
/// - `payload` (TRequest): Estructura de datos a enviar en el reporte.
/// - `onPressed` (ReportActionCallback&lt;TRequest, TResponse&gt;): Función asíncrona que ejecuta la acción.
/// - `buttonColor` (Color?): Color primario del botón. Si es nulo, usa el primario del tema.
/// - `isLoading` (bool): Permite forzar un estado de carga externo.
/// - `onSuccess` (ValueChanged&lt;TResponse&gt;?): Callback opcional al completar la acción con éxito.
/// - `onError` (ValueChanged<Object>?): Callback opcional si la acción falla.
class ReportActionButton<TRequest, TResponse> extends StatefulWidget {
  final String label;
  final IconData icon;
  final TRequest payload;
  final ReportActionCallback<TRequest, TResponse> onPressed;
  final Color? buttonColor;
  final bool isLoading;
  final ValueChanged<TResponse>? onSuccess;
  final ValueChanged<Object>? onError;

  /// Constructor de ReportActionButton.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  /// - `label` (String): Texto del botón.
  /// - `icon` (IconData): Ícono a mostrar junto al texto.
  /// - `payload` (TRequest): Objeto con los datos del reporte.
  /// - `onPressed` (ReportActionCallback&lt;TRequest, TResponse&gt;): Acción asíncrona de envío.
  /// - `buttonColor` (Color?): Color opcional del botón.
  /// - `isLoading` (bool): Estado de carga externo opcional.
  /// - `onSuccess` (ValueChanged&lt;TResponse&gt;?): Callback opcional en éxito.
  /// - `onError` (ValueChanged<Object>?): Callback opcional en error.
  const ReportActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.payload,
    required this.onPressed,
    this.buttonColor,
    this.isLoading = false,
    this.onSuccess,
    this.onError,
  });

  @override
  State<ReportActionButton<TRequest, TResponse>> createState() =>
      _ReportActionButtonState<TRequest, TResponse>();
}

class _ReportActionButtonState<TRequest, TResponse>
    extends State<ReportActionButton<TRequest, TResponse>> {
  bool _isInternalLoading = false;

  bool get _isProcessing => widget.isLoading || _isInternalLoading;

  Future<void> _handleTap() async {
    if (_isProcessing) return;

    setState(() {
      _isInternalLoading = true;
    });

    try {
      final response = await widget.onPressed(widget.payload);
      if (mounted && widget.onSuccess != null) {
        widget.onSuccess!(response);
      }
    } catch (error) {
      if (mounted && widget.onError != null) {
        widget.onError!(error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isInternalLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = widget.buttonColor ?? theme.colorScheme.primary;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: effectiveColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2.0,
      ),
      onPressed: _isProcessing ? null : _handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_isProcessing)
            const SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          else ...<Widget>[
            Icon(widget.icon, size: 22.0),
            const SizedBox(width: 10.0),
            Text(
              widget.label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
