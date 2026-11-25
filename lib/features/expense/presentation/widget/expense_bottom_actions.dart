import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/theme/app_text_styles.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_btn.dart';

class ExpenseBottomActions extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onSaveAndAdd;

  const ExpenseBottomActions({
    super.key,
    required this.onSave,
    required this.onSaveAndAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.h20,
          context.h15,
          context.h20,
          context.h10,
        ),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomBtn(
              text: LocaleKeys.save_expense.tr(),
              onPressed: onSave,
              height: 48,
              width: double.infinity,
              variant: ButtonVariant.primary,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.h5),
            CustomBtn(
              text: LocaleKeys.save_and_add_new.tr(),
              onPressed: onSaveAndAdd,
              height: 40,
              width: double.infinity,
              variant: ButtonVariant.text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
