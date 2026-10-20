import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/features/auth/presentation/pages/auth_page.dart';
import 'package:masrofy/features/home/presentation/page/home_page.dart';
import 'package:masrofy/features/notification/presentation/page/notification_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: NamedRoutes.authPage,
      name: NamedRoutes.authPage,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      path: NamedRoutes.homePage,
      name: NamedRoutes.homePage,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: NamedRoutes.notificationPage,
      name: NamedRoutes.notificationPage,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationPage();
      },
    ),
  ],
);
