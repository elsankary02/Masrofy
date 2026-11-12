import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';

class CustomCardSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomCardSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.h15),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.isDarkMode ? AppColors.cardDark : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.isDarkMode
                  ? AppColors.borderDark
                  : AppColors.grey200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
