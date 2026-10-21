import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class CustomQuickTools extends StatelessWidget {
  final String subTitle;
  final FaIconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  const CustomQuickTools({
    super.key,
    required this.subTitle,
    this.icon,
    this.color = AppColors.purple,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.isDarkMode ? AppColors.cardDark : Colors.white,
              border: Border.all(
                color: context.isDarkMode
                    ? AppColors.borderDark
                    : AppColors.grey200,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color!.withValues(alpha: 0.1),
                shape: .circle,
              ),
              child: FaIcon(icon, color: color, size: 20),
            ),
          ),
        ),
        SizedBox(height: context.h * .008),
        Text(
          subTitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.grey700,
          ),
        ),
      ],
    );
  }
}
