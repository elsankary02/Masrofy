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
    final bool isDone = goal.isCompleted;
    final Color accentColor = isDone ? AppColors.saving : goal.color;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDone
                ? AppColors.saving.withValues(alpha: 0.45)
                : (context.isDarkMode
                      ? AppColors.borderDark
                      : AppColors.borderLight),
          ),
        ),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(context.h10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isDone ? Icons.check_circle_rounded : (goal.icon),
              color: accentColor,
              size: 20,
            ),
          ),
          title: Text(
            goal.title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                '${goal.current} ${LocaleKeys.currency_egp.tr()}',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${LocaleKeys.from.tr()} ${goal.target} ${LocaleKeys.currency_egp.tr()}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: isDone
                      ? AppColors.saving
                      : (context.isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
                  fontWeight: isDone ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Text(
                '${goal.percentage}%',
                style: context.textTheme.bodySmall?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: context.h90,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: goal.progress,
                  color: accentColor,
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
