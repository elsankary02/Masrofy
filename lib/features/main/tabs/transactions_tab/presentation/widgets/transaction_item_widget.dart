import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionItemWidget({super.key, required this.transaction});

  String _resolveDisplayTitle(TransactionEntity item) {
    final trimmedTitle = item.title.trim();
    if (trimmedTitle.isNotEmpty && trimmedTitle != '-') {
      return trimmedTitle;
    }

    final rawKey = (item.categoryKey ?? item.subtitle).trim();
    if (rawKey.isNotEmpty && rawKey != '-') {
      return _localizeCategoryHint(rawKey);
    }

    return 'other'.tr();
  }

  String _localizeCategoryHint(String raw) {
    final normalized = raw
        .trim()
        .toLowerCase()
        .replaceAll('ة', 'ه')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا');

    if (normalized.contains('food') ||
        normalized.contains('طعام') ||
        normalized.contains('اكل')) {
      return 'food'.tr();
    }
    if (normalized.contains('transport') || normalized.contains('مواصلات')) {
      return 'transportation'.tr();
    }
    if (normalized.contains('bill') || normalized.contains('فواتير')) {
      return 'bills'.tr();
    }
    if (normalized.contains('shop') || normalized.contains('تسوق')) {
      return 'shopping'.tr();
    }
    if (normalized.contains('entertain') || normalized.contains('ترفيه')) {
      return 'entertainment'.tr();
    }
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.##');
    final timeLabel = DateFormat.jm(context.locale.languageCode)
        .format(transaction.date);
    final isExpense = transaction.isExpense;
    final sign = isExpense ? '-' : '+';
    final displayTitle = _resolveDisplayTitle(transaction);
    final arrowIcon = isExpense
        ? Icons.north_east_rounded
        : Icons.south_west_rounded;
    final arrowColor = isExpense ? AppColors.expense : AppColors.success;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _Leading(iconColor: arrowColor, icon: arrowIcon),
      title: _Title(title: displayTitle),
      subtitle: transaction.subtitle.isEmpty
          ? null
          : Text(
              transaction.subtitle,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 6,
        children: [
          Text(
            '$sign${formatter.format(transaction.amount)} ${LocaleKeys.currency_egp.tr()}',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: arrowColor,
            ),
          ),
          Text(
            timeLabel,
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
}

class _Leading extends StatelessWidget {
  const _Leading({required this.iconColor, required this.icon});

  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.h10),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
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
            : AppColors.textPrimaryLight,
      ),
    );
  }
}
