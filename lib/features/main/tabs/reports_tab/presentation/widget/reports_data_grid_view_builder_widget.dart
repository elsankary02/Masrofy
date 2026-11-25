import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../domain/entities/reports_entity.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';

class ReportsDataGridViewBuilderWidget extends StatelessWidget {
  const ReportsDataGridViewBuilderWidget({
    super.key,
    required List<SummaryCardEntity> cards,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is! ReportsLoaded) {
          return const SizedBox.shrink();
        }

        final cards = state.report.summaryCards;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.25,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final report = cards[index];

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
