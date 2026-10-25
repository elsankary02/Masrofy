import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/router/named_routes.dart';
import 'package:masrofy/features/auth/presentation/pages/auth_page.dart';
import 'package:masrofy/features/debts/debts_page.dart';
import 'package:masrofy/features/expense/expense_page.dart';
import 'package:masrofy/features/goals/presentation/page/goals_page.dart';
import 'package:masrofy/features/income/income_page.dart';
import 'package:masrofy/features/main/page/main_layout.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/pages/home_tab.dart';
import 'package:masrofy/features/main/tabs/more_tab/more_tab.dart';
import 'package:masrofy/features/main/tabs/reports_tab/reports_tab.dart';
import 'package:masrofy/features/main/tabs/transactions_tab/transactions_tab.dart';
import 'package:masrofy/features/notification/presentation/page/notification_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: NamedRoutes.auth,
      name: NamedRoutes.auth,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      path: NamedRoutes.notification,
      name: NamedRoutes.notification,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationPage();
      },
    ),
    GoRoute(
      path: NamedRoutes.main,
      name: NamedRoutes.main,
      builder: (BuildContext context, GoRouterState state) {
        return const MainLayout();
      },
    ),

    // Tabs
    GoRoute(
      path: NamedRoutes.home,
      name: NamedRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeTab();
      },
    ),
    GoRoute(
      path: NamedRoutes.reports,
      name: NamedRoutes.reports,
      builder: (BuildContext context, GoRouterState state) {
        return const ReportsTab();
      },
    ),
    GoRoute(
      path: NamedRoutes.more,
      name: NamedRoutes.more,
      builder: (BuildContext context, GoRouterState state) {
        return const MoreTab();
      },
    ),
    GoRoute(
      path: NamedRoutes.transactions,
      name: NamedRoutes.transactions,
      builder: (BuildContext context, GoRouterState state) {
        return const TransactionsTab();
      },
    ),

    // Quik Tools
    GoRoute(
      path: NamedRoutes.goals,
      name: NamedRoutes.goals,
      builder: (BuildContext context, GoRouterState state) {
        return const GoalsPage();
      },
    ),
    GoRoute(
      path: NamedRoutes.debts,
      name: NamedRoutes.debts,
      builder: (BuildContext context, GoRouterState state) {
        return const DebtsPage();
      },
    ),
    GoRoute(
      path: NamedRoutes.income,
      name: NamedRoutes.income,
      builder: (BuildContext context, GoRouterState state) {
        return const IncomePage();
      },
    ),
    GoRoute(
      path: NamedRoutes.expense,
      name: NamedRoutes.expense,
      builder: (BuildContext context, GoRouterState state) {
        return const ExpensePage();
      },
    ),
  ],
);
