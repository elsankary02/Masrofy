import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../data/models/debts_model.dart';
import '../../domain/entities/debt_entity.dart';

class DebetsCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final DebtEntity debts;

  const DebetsCardWidget({super.key, this.onTap, required this.debts});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final secondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final cardColor = debts is DebtsModel
        ? (debts as DebtsModel).color
        : Color(debts.colorValue);

    final double progress = debts.target <= 0
        ? 0.0
        : (debts.paidAmount / debts.target).clamp(0.0, 1.0).toDouble();
    final int percentage = (progress * 100).round();
    final formatter = NumberFormat('#,##0.##');

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.h15),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: cardColor.withValues(alpha: isDark ? 0.35 : 0.22),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        debts.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (debts.subtitle.isNotEmpty) ...[
                        SizedBox(height: context.h5),
                        Text(
                          debts.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: context.h10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.h10,
                    vertical: context.h5,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${LocaleKeys.remaining_label.tr()} ${formatter.format(debts.current)} ${LocaleKeys.currency_egp.tr()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cardColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.h15),
            SizedBox(
              height: context.h10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: cardColor.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(cardColor),
                ),
              ),
            ),
            SizedBox(height: context.h10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$percentage%',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cardColor,
                  ),
                ),
                Text(
                  '${LocaleKeys.total.tr()} ${formatter.format(debts.target)} ${LocaleKeys.currency_egp.tr()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
