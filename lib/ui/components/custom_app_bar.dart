import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import 'refresh_button.dart';

/// AppBar personalizada y reutilizable para las pantallas de la aplicación.
///
/// Attributes:
/// - `title` (String): Título que se mostrará en el encabezado.
/// - `onRefresh` (VoidCallback?): Callback opcional para la acción de actualización.
/// - `isRefreshing` (bool): Estado de carga para el botón de recarga.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onRefresh;
  final bool isRefreshing;

  /// Constructor de CustomAppBar.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  /// - `title` (String): Texto del título principal.
  /// - `onRefresh` (VoidCallback?): Acción de refresco opcional.
  /// - `isRefreshing` (bool): Estado de carga del refresco.
  const CustomAppBar({
    super.key,
    required this.title,
    this.onRefresh,
    this.isRefreshing = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);

    return AppBar(
      title: Text(title, style: theme.textTheme.titleLarge),
      centerTitle: false,
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: <Widget>[
        if (onRefresh != null)
          RefreshButton(onRefresh: onRefresh!, isLoading: isRefreshing),
        IconButton(
          tooltip: 'Cambiar tema',
          icon: Icon(
            _getThemeIcon(themeProvider.themeMode),
            color: theme.colorScheme.primary,
          ),
          onPressed: () => themeProvider.toggleTheme(),
        ),
        IconButton(
          tooltip: 'Acerca de',
          icon: Icon(Icons.info_rounded, color: theme.colorScheme.primary),
          onPressed: () => context.push('/about'),
        ),
      ],
    );
  }
}
