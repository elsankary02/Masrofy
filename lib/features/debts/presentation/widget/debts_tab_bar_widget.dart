import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/debts/presentation/cubit/debts_cubit.dart';

class DebtsTabBarWidget extends StatefulWidget {
  const DebtsTabBarWidget({super.key});

  @override
  State<DebtsTabBarWidget> createState() => _DebtsTabBarWidgetState();
}

class _DebtsTabBarWidgetState extends State<DebtsTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final activeColor = AppColors.expense;
    final inActiveColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    return TabBar(
      labelColor: activeColor,
      unselectedLabelColor: inActiveColor,
      controller: _tabController,
      dividerColor: Colors.transparent,
      unselectedLabelStyle: context.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      labelStyle: context.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      indicatorColor: activeColor,
      indicatorSize: TabBarIndicatorSize.tab,

      onTap: (index) {
        final status = [DebtsStatus.isActive, DebtsStatus.paid];

        context.read<DebtsCubit>().debtsStatusFunc(status[index]);
      },
      tabs: [
        Tab(text: LocaleKeys.status_active.tr()),

        Tab(text: LocaleKeys.status_paid.tr()),
      ],
    );
  }
}
