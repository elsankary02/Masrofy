import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/theme/app_text_styles.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;

  const AmountInputField({super.key, this.controller, this.hint});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.isDarkMode ? AppColors.cardDark : Colors.white,
        border: Border.all(
          color: context.isDarkMode ? AppColors.borderDark : AppColors.grey200,
        ),
      ),
      child: Row(
        children: [
          // Currency
          Text(
            LocaleKeys.currency_egp.tr(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          // Amount
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
              decoration: InputDecoration(
                filled: false,
                hintText: hint ?? '0',
                hintStyle: context.textTheme.titleMedium!.copyWith(
                  color: colors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
