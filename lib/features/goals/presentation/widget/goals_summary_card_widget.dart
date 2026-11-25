import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_status_cubit.dart';

class GoalsSummaryCardWidget extends StatelessWidget {
  const GoalsSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      builder: (context, state) {
        final int totalGoalsCount = state.goals.length;
        final int achievedGoalsCount = state.goals
            .where((goal) => goal.isCompleted)
            .length;

        return Container(
          padding: EdgeInsets.all(context.h20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: AppColors.goalsGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.total_goals.tr(),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      totalGoalsCount.toString(),
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$achievedGoalsCount ${LocaleKeys.completed_from.tr()} $totalGoalsCount',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.95),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppImages.goals,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}
