import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class IncomeItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String frequency;
  final String amount;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  const IncomeItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.frequency,
    required this.amount,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 3),
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
        splashColor: Colors.transparent,
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: _Leading(iconColor: iconColor, icon: icon),
        title: _Title(title: title),
        subtitle: Text(
          subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.isDarkMode
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 8,
          children: [
            Text(
              '$amount ${LocaleKeys.currency_egp.tr()}',
              style: _style(context),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 4,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: context.isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                Text(
                  frequency,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? _style(BuildContext context) => context.textTheme.titleMedium
      ?.copyWith(color: AppColors.income, fontWeight: FontWeight.bold);
}

class _Leading extends StatelessWidget {
  const _Leading({required this.iconColor, required this.icon});

  final Color? iconColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.h15),
      decoration: BoxDecoration(
        color: iconColor!.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.grey700,
      ),
    );
  }
}
