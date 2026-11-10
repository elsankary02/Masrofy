import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/reports_tab/data/models/reports_model.dart';

class ReportsDataGridViewBuilderWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.25,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reportsData(context).length,
      itemBuilder: (context, index) {
        final report = reportsData(context)[index];

        return _ReportsSummaryCardWidget(
          label: report.label,
          amount: report.amount,
          subText: report.subText,
          isPercentage: report.isPercentage,
          changeText: report.changeText,
          changeColor: report.changeColor,
        );
      },
    );
  }
}

class _ReportsSummaryCardWidget extends StatelessWidget {
  final String label;
  final String amount;
  final String? changeText;
  final Color? changeColor;
  final String subText;
  final bool isPercentage;
  const _ReportsSummaryCardWidget({
    required this.label,
    required this.amount,
    this.changeText,
    this.changeColor,
    required this.subText,
    this.isPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: context.h15,
        top: context.h15,
        bottom: context.h15,
      ),
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
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          Row(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: context.textTheme.titleLarge),
              if (!isPercentage)
                Text(
                  'EGP ',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          if (changeText != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  changeText!,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: changeColor,
                  ),
                ),
              ],
            ),
          ],
          if (subText.isNotEmpty) ...[
            Text(
              subText,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
