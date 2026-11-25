import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/router/go_router.dart';
import '../../../core/router/named_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/constants/locale_keys.g.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../core/widgets/custom_btn.dart';
import '../tabs/home_tab/presentation/pages/home_tab.dart';
import '../tabs/more_tab/presentation/pages/more_tab.dart';
import '../tabs/reports_tab/presentation/pages/reports_tab.dart';
import '../tabs/transactions_tab/presentation/page/transactions_tab.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  late final List<Widget> _tabs = [
    HomeTab(key: homeTabKey),
    ReportsTab(key: reportsTabKey),
    TransactionsTab(key: transactionsTabKey),
    const MoreTab(),
  ];

  void _refreshTabAt(int index) {
    if (index == 0) {
      homeTabKey.currentState?.refreshHome();
    } else if (index == 1) {
      reportsTabKey.currentState?.refreshReports();
    } else if (index == 2) {
      transactionsTabKey.currentState?.refreshTransactions();
    }
  }

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
    _refreshTabAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _QuickAddFab(
        onReturnedFromAdd: () => _refreshTabAt(_currentIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        elevation: 0,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              currentIndex: _currentIndex,
              index: 0,
              icon: Icons.home_rounded,
              label: LocaleKeys.home.tr(),
              onTap: _onTabSelected,
            ),
            _NavItem(
              currentIndex: _currentIndex,
              index: 1,
              icon: Icons.bar_chart_rounded,
              label: LocaleKeys.reports.tr(),
              onTap: _onTabSelected,
            ),
            const SizedBox(width: 50),
            _NavItem(
              currentIndex: _currentIndex,
              index: 2,
              icon: Icons.receipt_long_rounded,
              label: LocaleKeys.transactions.tr(),
              onTap: _onTabSelected,
            ),
            _NavItem(
              currentIndex: _currentIndex,
              index: 3,
              icon: Icons.more_horiz_rounded,
              label: LocaleKeys.more.tr(),
              onTap: _onTabSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAddFab extends StatelessWidget {
  final VoidCallback? onReturnedFromAdd;

  const _QuickAddFab({this.onReturnedFromAdd});

  void _openQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            context.h20,
            context.h20,
            context.h20,
            context.h25,
          ),
          decoration: BoxDecoration(
            color: context.isDarkMode ? AppColors.surfaceDark : AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: context.h15,
            children: [
              Text(
                LocaleKeys.add_new_transaction.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomBtn(
                text: LocaleKeys.add_expense.tr(),
                onPressed: () async {
                  Navigator.pop(sheetContext);
                  await router.push(NamedRoutes.expense);
                  onReturnedFromAdd?.call();
                },
              ),
              CustomBtn(
                text: LocaleKeys.add_new_income.tr(),
                variant: ButtonVariant.text,
                onPressed: () async {
                  Navigator.pop(sheetContext);
                  await router.push(NamedRoutes.income);
                  onReturnedFromAdd?.call();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openQuickActions(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          border: Border.all(
            color: context.isDarkMode
                ? AppColors.surfaceDark
                : AppColors.backgroundLight,
            width: 4,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, size: 26, color: AppColors.white),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? AppColors.primaryDark
        : (context.isDarkMode
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight);

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.textTheme.bodySmall!.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
