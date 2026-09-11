import 'package:flutter/material.dart';

/// Clase estática que contiene la definición centralizada de colores de la aplicación.
///
/// Attributes:
/// - `brandPrimary`: Púrpura eléctrico principal para acciones destacadas e identidad primaria.
/// - `brandSecondary`: Púrpura/Magenta brillante para elementos secundarios, badges o acentos.
/// - `brandDarkBlue`: Azul profundo utilizado para gradientes, contenedores o elementos de fondo contrastantes.
/// - `ok`: Estado Exitoso / Normalidad (Verde esmeralda sobrio).
/// - `warn`: Estado de Advertencia / Caída de tensión (Ámbar cálido).
/// - `danger`: Estado Crítico / Corte Eléctrico (Rojo rosado saturado, congruente con tonos fríos/púrpuras).
/// - `info`: Estado Informativo / Fluctuación (Azul eléctrico derivado de la paleta original #145DE0).
class AppColors {
  AppColors._();

  // --- Identidad de Marca (Brand Palette) ---
  static const Color brandPrimary = Color(0xFF733EE1);
  static const Color brandSecondary = Color(0xFFBC51F3);
  static const Color brandDarkBlue = Color(0xFF212ECF);

  // --- Colores Semánticos y Estados (Armonizados) ---
  static const Color ok = Color(0xFF10B981);
  static const Color warn = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFF43F5E);
  static const Color info = Color(0xFF145DE0);

  // --- Fondos y Superficies - Dark Mode ---
  static const Color bg1Dark = Color(0xFF020617);
  static const Color bg2Dark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xBF0F172A);
  static const Color textPrimaryDark = Color(0xFFE2E8F0);
  static const Color textMutedDark = Color(0xFFCBD5E1);

  // --- Fondos y Superficies - Light Mode ---
  static const Color bg1Light = Color(0xFFF8FAFC);
  static const Color bg2Light = Color(0xFFF1F5F9);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textMutedLight = Color(0xFF64748B);

  // --- Líneas y Bordes ---
  static const Color lineDark = Color(0x3D94A3B8);
  static const Color lineLight = Color(0x3364748B);

  /// Esquema de colores para el tema Oscuro.
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: brandPrimary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: brandDarkBlue,
    onPrimaryContainer: Color(0xFFE0E7FF),
    secondary: brandSecondary,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF581C87),
    onSecondaryContainer: Color(0xFFF3E8FF),
    tertiary: info,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF1E3A8A),
    onTertiaryContainer: Color(0xFFDBEAFE),
    error: danger,
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFF881337),
    onErrorContainer: Color(0xFFFFE4E6),
    surface: bg2Dark,
    onSurface: textPrimaryDark,
    onSurfaceVariant: textMutedDark,
    outline: lineDark,
  );

  /// Esquema de colores para el tema Claro.
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: brandPrimary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEEF2FF),
    onPrimaryContainer: brandDarkBlue,
    secondary: brandSecondary,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFF3E8FF),
    onSecondaryContainer: Color(0xFF581C87),
    tertiary: info,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFDBEAFE),
    onTertiaryContainer: Color(0xFF1E3A8A),
    error: danger,
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFE4E6),
    onErrorContainer: Color(0xFF881337),
    surface: bg1Light,
    onSurface: textPrimaryLight,
    onSurfaceVariant: textMutedLight,
    outline: lineLight,
  );
}
