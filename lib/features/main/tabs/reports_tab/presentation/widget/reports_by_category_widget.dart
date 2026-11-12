import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/main/tabs/reports_tab/presentation/widget/category_legend_list_widget.dart';

class ExpensesByCategoryWidget extends StatelessWidget {
  const ExpensesByCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(17),
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
          SizedBox(width: 200, height: 200, child: const _DonutChart()),
          SizedBox(height: context.h35),
          CategoryLegendListWidget(),
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
    return CustomPaint(
      painter: _DonutChartPainter(isDark: context.isDarkMode),
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
            SizedBox(height: 4),
            Text(
              '15,400',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final bool isDark;

  _DonutChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 28.0;
    const gapAngle = 0.04; // small gap between segments

    // Category data: percentage, color
    final segments = [
      (0.30, AppColors.expense),
      (0.25, AppColors.blue),
      (0.15, AppColors.accent),
      (0.12, AppColors.purple),
      (0.10, AppColors.orange),
      (0.08, AppColors.grey400),
    ];

    // Background ring
    final bgPaint = Paint()
      ..color = isDark ? AppColors.borderDark : AppColors.grey100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw segments
    var startAngle = -pi / 2; // start from top
    for (final (fraction, color) in segments) {
      final sweepAngle = 2 * pi * fraction - gapAngle;
      final paint = Paint()
        ..color = color
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
      isDark != oldDelegate.isDark;
}
