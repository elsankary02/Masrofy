import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';

class DebtsSummaryCardWidget extends StatelessWidget {
  const DebtsSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final num totalTarget = debtsModel.fold(
      0,
      (sum, item) => sum + item.target,
    );
    final num totalCurrent = debtsModel.fold(
      0,
      (sum, item) => sum + item.current,
    );

    final num totalPaid = totalTarget - totalCurrent;
    final double totalProgress = totalTarget == 0 ? 0 : totalPaid / totalTarget;
    final int totalPercentage = (totalProgress * 100).round();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.h25),
      decoration: BoxDecoration(
        gradient: AppColors.debtsGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.expense.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _TotalDebtsWidget(
                title: LocaleKeys.total_debts.tr(),
                price: totalTarget.toInt(),
              ),
              _TotalDebtsWidget(
                title: LocaleKeys.remaining_label.tr(),
                price: totalCurrent.toInt(),
              ),
            ],
          ),
          _CircularProgress(
            progress: totalProgress,
            percentage: totalPercentage,
          ),
        ],
      ),
    );
  }
}

class _TotalDebtsWidget extends StatelessWidget {
  final String title;
  final int price;
  const _TotalDebtsWidget({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.labelLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          spacing: 2,
          children: [
            Text(
              "$price",
              style: context.textTheme.headlineMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              LocaleKeys.currency_egp.tr(),
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircularProgress extends StatelessWidget {
  final double progress;
  final int percentage;
  const _CircularProgress({required this.progress, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: context.h95,
              height: context.h95,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 5,
                color: Colors.white,
                backgroundColor: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            Text(
              '$percentage%',
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Text(
          LocaleKeys.paid_label.tr(),
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
