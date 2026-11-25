import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';

class CategoryLegendListWidget extends StatelessWidget {
  const CategoryLegendListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is! ReportsLoaded) {
          return const SizedBox.shrink();
        }

        final categories = state.report.categories;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          separatorBuilder: (context, index) => SizedBox(height: context.h20),
          itemBuilder: (context, index) {
            final item = categories[index];
            return _CategoryLegend(
              label: item.label,
              color: item.color,
              percentage: item.percentageText,
              amount: item.formattedAmount,
            );
          },
        );
      },
    );
  }
}

// ── Category Legend ──
class _CategoryLegend extends StatelessWidget {
  final String label;
  final Color color;
  final String percentage;
  final String amount;

  const _CategoryLegend({
    required this.label,
    required this.color,
    required this.percentage,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    label,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 20,
                children: [
                  Text(
                    percentage,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    amount,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
