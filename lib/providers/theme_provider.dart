import 'package:flutter/material.dart';

/// Provider encargado de gestionar el estado del tema (Claro, Oscuro o Sistema).
///
/// Attributes:
/// - `_themeMode` (ThemeMode): Modo de tema actual seleccionado por el usuario.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;

  /// Constructor de ThemeProvider.
  ///
  /// Args:
  /// - `initialThemeMode` (ThemeMode): Modo inicial del tema. Por defecto es ThemeMode.system.
  ThemeProvider({ThemeMode initialThemeMode = ThemeMode.system})
    : _themeMode = initialThemeMode;

  /// Obtiene el modo de tema actual.
  ThemeMode get themeMode => _themeMode;

  /// Indica si la opción seleccionada explícitamente es el tema del sistema.
  bool get isSystemMode => _themeMode == ThemeMode.system;

  /// Determina si el tema visual activo es oscuro, resolviendo el brillo del sistema si está en ThemeMode.system.
  ///
  /// Args:
  /// - `context` (BuildContext): Contexto de la aplicación para consultar el brillo actual del sistema.
  ///
  /// Returns:
  /// - `bool`: `true` si la interfaz se está mostrando en modo oscuro, `false` en caso contrario.
  bool isDarkModeActive(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  /// Establece un nuevo modo de tema y notifica a los escuchas.
  ///
  /// Args:
  /// - `mode` (ThemeMode): Nuevo modo de tema a aplicar.
  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  /// Alterna cíclicamente entre los tres modos de tema: Sistema -> Claro -> Oscuro -> Sistema.
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
    }
  }
}
