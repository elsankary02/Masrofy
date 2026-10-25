import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class GoalTabItemWidget extends StatelessWidget {
  final bool selected;
  final String title;
  final VoidCallback? onTap;
  const GoalTabItemWidget({
    super.key,
    this.onTap,
    required this.selected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final activeColor = AppColors.purple;
    final inActiveColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: context.h10),
            child: Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                color: selected ? activeColor : inActiveColor,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: context.h10),
          Container(
            height: context.h3,
            width: context.h200,
            decoration: BoxDecoration(
              color: selected ? activeColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
