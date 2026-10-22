import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/pages/home_tab.dart';
import 'package:masrofy/features/main/tabs/more_tab/more_tab.dart';
import 'package:masrofy/features/main/tabs/reports_tab/reports_tab.dart';
import 'package:masrofy/features/main/tabs/transactions_tab/transactions_tab.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    ReportsTab(),
    TransactionsTab(),
    MoreTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          border: Border.all(color: AppColors.backgroundLight, width: 4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FaIcon(FontAwesomeIcons.plus, size: 25, color: AppColors.white),
      ),

      bottomNavigationBar: BottomAppBar(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(
              index: 0,
              icon: FontAwesomeIcons.houseChimney,
              label: LocaleKeys.home.tr(),
            ),
            _item(
              index: 1,
              icon: FontAwesomeIcons.chartSimple,
              label: LocaleKeys.reports.tr(),
            ),
            const SizedBox(width: 50),
            _item(
              index: 2,
              icon: FontAwesomeIcons.circleDollarToSlot,
              label: LocaleKeys.transactions.tr(),
            ),
            _item(
              index: 3,
              icon: FontAwesomeIcons.ellipsis,
              label: LocaleKeys.more.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required FaIconData? icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppColors.primaryDark : Colors.grey;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 18, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.textTheme.bodySmall!.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
