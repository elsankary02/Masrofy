import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';

class ExpenseDescriptionSection extends StatelessWidget {
  final TextEditingController controller;

  const ExpenseDescriptionSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colors = context.theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            LocaleKeys.description_hint.tr(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: context.h15, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? AppColors.cardDark : Colors.white,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.grey200,
            ),
          ),
          child: TextField(
            controller: controller,
            minLines: 1,
            maxLines: 3,
            textInputAction: TextInputAction.done,
            style: AppTextStyles.bodyMedium.copyWith(color: colors.onSurface),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              hintText: LocaleKeys.description_optional.tr(),
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: colors.onSurfaceVariant.withValues(alpha: 0.65),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
