import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layouts/main_layout.dart';
import '../screens/history_screen.dart';
import '../screens/report_screen.dart';

/// Configuración centralizada de rutas de la aplicación utilizando GoRouter.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final String title = state.uri.path == '/history'
              ? 'Historial de Reportes'
              : 'Gestión de Servicio';

          return MainLayout(
            title: title,
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const ReportScreen();
            },
          ),
          GoRoute(
            path: '/history',
            builder: (BuildContext context, GoRouterState state) {
              return const HistoryScreen();
            },
          ),
        ],
      ),
    ],
  );
}
