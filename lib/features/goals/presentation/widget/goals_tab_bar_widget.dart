import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_status_cubit.dart';

class GoalsTabBarWidget extends StatefulWidget {
  const GoalsTabBarWidget({super.key});

  @override
  State<GoalsTabBarWidget> createState() => _GoalsTabBarWidgetState();
}

class _GoalsTabBarWidgetState extends State<GoalsTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialStatus = context.read<GoalsCubit>().state.status;
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initialStatus == GoalsStatus.active ? 0 : 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final activeColor = AppColors.purple;
    final inActiveColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return BlocListener<GoalsCubit, GoalsState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        final targetIndex = state.status == GoalsStatus.active ? 0 : 1;
        if (_tabController.index != targetIndex) {
          _tabController.animateTo(targetIndex);
        }
      },
      child: TabBar(
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
          final status = [GoalsStatus.active, GoalsStatus.completed];
          context.read<GoalsCubit>().changeGoalStatus(status[index]);
        },
        tabs: [
          Tab(text: LocaleKeys.status_active.tr()),
          Tab(text: LocaleKeys.completed_goals.tr()),
        ],
      ),
    );
  }
}
