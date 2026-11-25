import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../cubit/debts_cubit.dart';
import '../cubit/debts_state.dart';

class DebtsSummaryCardWidget extends StatelessWidget {
  const DebtsSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0');

    return BlocBuilder<DebtsCubit, DebtsState>(
      builder: (context, state) {
        final num totalTarget = state.debts.fold(
          0,
          (sum, item) => sum + item.target,
        );
        final num totalCurrent = state.debts.fold(
          0,
          (sum, item) => sum + item.current,
        );

        final num totalPaid = (totalTarget - totalCurrent).clamp(
          0,
          totalTarget,
        );
        final double totalProgress = totalTarget <= 0
            ? 0.0
            : (totalPaid / totalTarget).clamp(0.0, 1.0).toDouble();
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
                spacing: context.h10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TotalDebtsWidget(
                    title: LocaleKeys.total_debts.tr(),
                    price: formatter.format(totalTarget.round()),
                  ),
                  _TotalDebtsWidget(
                    title: LocaleKeys.remaining_label.tr(),
                    price: formatter.format(totalCurrent.round()),
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
      },
    );
  }
}

class _TotalDebtsWidget extends StatelessWidget {
  final String title;
  final String price;
  const _TotalDebtsWidget({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.labelLarge?.copyWith(
            color: AppColors.white.withValues(alpha: 0.85),
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              price,
              style: context.textTheme.headlineMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              LocaleKeys.currency_egp.tr(),
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.white.withValues(alpha: 0.9),
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
                color: AppColors.white,
                backgroundColor: AppColors.white.withValues(alpha: 0.25),
              ),
            ),
            Text(
              '$percentage%',
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          LocaleKeys.paid_label.tr(),
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
