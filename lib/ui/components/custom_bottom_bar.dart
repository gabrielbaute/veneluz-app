import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Barra de navegación inferior que coordina el cambio de pantallas mediante GoRouter.
///
/// Attributes:
/// - `currentPath` (String): Ruta actual utilizada para seleccionar el ítem activo.
class CustomBottomBar extends StatelessWidget {
  final String currentPath;

  /// Constructor de CustomBottomBar.
  ///
  /// Args:
  /// - `key` (Key?): Llave del widget.
  /// - `currentPath` (String): Ruta activa en GoRouter.
  const CustomBottomBar({super.key, required this.currentPath});

  int _getSelectedIndex() {
    if (currentPath.startsWith('/history')) return 1;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/history');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NavigationBar(
      selectedIndex: _getSelectedIndex(),
      onDestinationSelected: (int index) => _onItemTapped(context, index),
      backgroundColor: theme.colorScheme.surface,
      indicatorColor: theme.colorScheme.primaryContainer,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.bolt_outlined),
          selectedIcon: Icon(Icons.bolt),
          label: 'Reportar',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_rounded),
          selectedIcon: Icon(Icons.history_toggle_off_rounded),
          label: 'Historial',
        ),
      ],
    );
  }
}
