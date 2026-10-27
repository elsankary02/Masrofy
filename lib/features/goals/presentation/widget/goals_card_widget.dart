import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/goals/data/models/goals_card_model.dart';

class GoalsCardWidget extends StatelessWidget {
  final GoalsCardModel goal;
  final VoidCallback? onTap;
  const GoalsCardWidget({super.key, required this.goal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.isDarkMode
                ? AppColors.borderDark
                : AppColors.borderLight,
          ),
        ),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(context.h10),
            decoration: BoxDecoration(
              color: goal.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(goal.icon, color: goal.color, size: 16),
          ),
          title: Text(goal.title, style: context.textTheme.titleMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                '${goal.current} ${LocaleKeys.currency_egp.tr()}',
                style: context.textTheme.bodyMedium,
              ),
              Text(
                "${LocaleKeys.from.tr()} ${goal.target} ${LocaleKeys.currency_egp.tr()}",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              Text(
                '${goal.percentage}%',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              SizedBox(
                width: context.h90,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: goal.progress,
                  minHeight: 6,
                  backgroundColor: context.isDarkMode
                      ? AppColors.borderDark
                      : AppColors.grey100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
