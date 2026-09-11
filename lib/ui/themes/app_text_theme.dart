import 'package:flutter/material.dart';

/// Clase que define la jerarquía tipográfica unificada para la aplicación.
///
/// Attributes:
/// - `displayFontFamily` (const): Nombre de la fuente para encabezados y números.
/// - `bodyFontFamily` (const): Nombre de la fuente para cuerpo y texto general.
class AppTextTheme {
  AppTextTheme._();

  static const String displayFontFamily = 'SpaceGrotesk';
  static const String bodyFontFamily = 'PlusJakartaSans';

  /// Crea la configuración de TextTheme para Material 3 basada en los colores recibidos.
  ///
  /// Args:
  /// - `textColor` (Color): Color del texto principal para la variación de tema.
  /// - `mutedColor` (Color): Color secundario/atenuado para etiquetas de contexto.
  ///
  /// Returns:
  /// - `TextTheme`: Configuración completa de tipografías y tamaños.
  static TextTheme createTextTheme({
    required Color textColor,
    required Color mutedColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.03,
      ),
      displayMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.02,
      ),
      displaySmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.02,
      ),
      titleLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: mutedColor,
      ),
      labelLarge: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.01,
      ),
      labelMedium: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: mutedColor,
        letterSpacing: 0.05,
      ),
      labelSmall: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: mutedColor,
        letterSpacing: 0.08,
      ),
    );
  }
}
