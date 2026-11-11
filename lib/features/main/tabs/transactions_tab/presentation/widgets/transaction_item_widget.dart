import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class TransactionItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String amount;
  final IconData? icon;
  final Color? iconColor;
  final bool? isHighlighted;
  const TransactionItemWidget({
    super.key,

    this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.amount,
    this.iconColor,
    this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
          Text(
            time,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle? _style(BuildContext context) =>
      context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700);
}

class _Leading extends StatelessWidget {
  const _Leading({required this.iconColor, required this.icon});

  final Color? iconColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.h10),
      decoration: BoxDecoration(
        color: iconColor!.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iconColor, size: 16),
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
