import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/reports_tab/data/models/category_legend_model.dart';

class CategoryLegendListWidget extends StatelessWidget {
  const CategoryLegendListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (context, index) => SizedBox(height: context.h20),
      itemBuilder: (context, index) {
        final items = categories[index];
        return _CategoryLegend(
          label: items.label,
          color: items.color,
          percentage: items.percentage,
          amount: items.amount,
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
          padding: EdgeInsetsGeometry.all(4),
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
