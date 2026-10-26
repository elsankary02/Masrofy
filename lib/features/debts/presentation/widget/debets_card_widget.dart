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
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.h15),
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.isDarkMode
                ? AppColors.borderDark
                : AppColors.borderLight,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      debts.subtitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: context.isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),

                Text(
                  '${LocaleKeys.remaining_label.tr()} ${debts.current} ${LocaleKeys.currency_egp.tr()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
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
                  backgroundColor: context.isDarkMode
                      ? AppColors.borderDark
                      : AppColors.grey100,
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
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                Text(
                  '${LocaleKeys.total.tr()} ${debts.target} ${LocaleKeys.currency_egp.tr()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
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
}
