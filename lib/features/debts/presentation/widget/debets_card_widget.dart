import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';

class DebetsCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final DebtsModel debts;
  const DebetsCardWidget({super.key, this.onTap, required this.debts});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final secondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.h15),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: debts.color.withValues(alpha: isDark ? 0.35 : 0.22),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      debts.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: context.h5),
                    Text(
                      debts.subtitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.h10,
                    vertical: context.h5,
                  ),
                  decoration: BoxDecoration(
                    color: debts.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${LocaleKeys.remaining_label.tr()} ${debts.current} ${LocaleKeys.currency_egp.tr()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: debts.color,
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
                  value: debts.progress,
                  backgroundColor: debts.color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(debts.color),
                ),
              ),
            ),
            SizedBox(height: context.h10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${debts.percentage}%',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: debts.color,
                  ),
                ),
                Text(
                  '${LocaleKeys.total.tr()} ${debts.target} ${LocaleKeys.currency_egp.tr()}',
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
