import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/theme/app_text_styles.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_text_form_field.dart';

class ExpenseDescriptionSection extends StatelessWidget {
  final TextEditingController controller;

  const ExpenseDescriptionSection({super.key, required this.controller});

  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.description_optional.tr(),
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        SizedBox(width: context.h10),

        Expanded(
          child: CustomTextField(
            controller: controller,
            hint: LocaleKeys.description_optional.tr(),
            maxLines: 1,
            radius: 14,
            filled: true,

            fillColor: context.isDarkMode ? AppColors.cardDark : Colors.white,
            enabledBorderColor: context.theme.colorScheme.outline.withValues(
              alpha: 0.15,
            ),
            focusedBorderColor: context.theme.colorScheme.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
