import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../domain/entities/reports_entity.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import 'category_legend_list_widget.dart';

class ExpensesByCategoryWidget extends StatelessWidget {
  const ExpensesByCategoryWidget({
    super.key,
    required int totalAmount,
    required List<CategoryBreakdownEntity> categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(17),
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
          Text(
            LocaleKeys.expenses_by_category.tr(),
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.h35),
          const SizedBox(width: 200, height: 200, child: _DonutChart()),
          SizedBox(height: context.h35),
          const CategoryLegendListWidget(),
        ],
      ),
    );
  }
}

// ── Donut Chart (Custom Painter) ──
class _DonutChart extends StatelessWidget {
  const _DonutChart();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final categories = state is ReportsLoaded
            ? state.report.categories
            : const <CategoryBreakdownEntity>[];
        final totalAmount = state is ReportsLoaded
            ? state.report.totalExpensesAmount
            : 0;

        return CustomPaint(
          painter: _DonutChartPainter(
            isDark: context.isDarkMode,
            categories: categories,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.total.tr(),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  totalAmount.toString(),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final bool isDark;
  final List<CategoryBreakdownEntity> categories;

  _DonutChartPainter({required this.isDark, required this.categories});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 28.0;
    const gapAngle = 0.04; // small gap between segments

    // Background ring
    final bgPaint = Paint()
      ..color = isDark ? AppColors.borderDark : AppColors.grey100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw active segments from real data
    final activeSegments = categories.where((c) => c.fraction > 0).toList();
    if (activeSegments.isEmpty) return;

    var startAngle = -pi / 2; // start from top
    for (final seg in activeSegments) {
      final sweepAngle = max(0.0, 2 * pi * seg.fraction - gapAngle);
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) =>
      isDark != oldDelegate.isDark || categories != oldDelegate.categories;
}
