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
      floatingActionButton: _FloatingActionButton(),

      bottomNavigationBar: BottomAppBar(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        elevation: 0,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Item(
              currentIndex: _currentIndex,
              index: 0,
              iconSelected: FontAwesomeIcons.solidHouse,
              iconUnSelected: FontAwesomeIcons.house,
              label: LocaleKeys.home.tr(),
              onTap: (index) => setState(() => _currentIndex = index),
            ),
            _Item(
              currentIndex: _currentIndex,
              index: 1,
              iconSelected: FontAwesomeIcons.solidChartBar,
              iconUnSelected: FontAwesomeIcons.chartBar,
              label: LocaleKeys.reports.tr(),
              onTap: (index) => setState(() => _currentIndex = index),
            ),
            const SizedBox(width: 50),
            _Item(
              currentIndex: _currentIndex,
              index: 2,
              iconSelected: FontAwesomeIcons.solidCreditCard,
              iconUnSelected: FontAwesomeIcons.creditCard,
              label: LocaleKeys.transactions.tr(),
              onTap: (index) => setState(() => _currentIndex = index),
            ),
            _Item(
              currentIndex: _currentIndex,
              index: 3,
              iconSelected: FontAwesomeIcons.ellipsis,
              iconUnSelected: FontAwesomeIcons.ellipsis,
              label: LocaleKeys.more.tr(),
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => Container(),
      ),
      child: Container(
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
    );
  }
}

class _Item extends StatelessWidget {
  final FaIconData? iconSelected, iconUnSelected;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _Item({
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.iconSelected,
    this.iconUnSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final color = isSelected ? AppColors.primaryDark : Colors.grey;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              isSelected ? iconSelected : iconUnSelected,
              size: 18,
              color: color,
            ),
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
