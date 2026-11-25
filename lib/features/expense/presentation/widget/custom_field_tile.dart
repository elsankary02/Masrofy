import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/theme/app_text_styles.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class CustomFieldTile extends StatelessWidget {
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  const CustomFieldTile({
    super.key,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return Row(
      children: [
        // Label
        SizedBox(
          width: 85,
          child: Text(
            label,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Field
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
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
                ),
                child: trailing,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
