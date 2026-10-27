import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_btn.dart';
import 'package:masrofy/core/widgets/custom_text_form_field.dart';

class DebtsBottomSheetWidget extends StatelessWidget {
  final bool isEditing;
  final TextEditingController? titleController;
  final TextEditingController? creditorController;
  final TextEditingController? totalController;
  final TextEditingController? paidController;
  final VoidCallback? onDelete;
  final VoidCallback? onSave;
  const DebtsBottomSheetWidget({
    super.key,
    required this.isEditing,
    this.titleController,
    this.creditorController,
    this.totalController,
    this.paidController,
    this.onDelete,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: context.viewInsets.bottom,
        left: context.h20,
        right: context.h20,
      ),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.surfaceDark : AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: context.h20,
          children: [
            Text(
              isEditing
                  ? LocaleKeys.edit_debt.tr()
                  : LocaleKeys.add_new_debt.tr(),
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              labelText: LocaleKeys.debt_title.tr(),
              controller: titleController,
            ),
            CustomTextField(
              labelText: LocaleKeys.creditor.tr(),
              controller: creditorController,
            ),
            CustomTextField(
              labelText: LocaleKeys.current_amount.tr(),
              controller: totalController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              labelText: LocaleKeys.paid_amount.tr(),
              controller: paidController,
              keyboardType: TextInputType.number,
            ),
            if (isEditing && onDelete != null)
              CustomBtn(
                text: LocaleKeys.delete_debt.tr(),
                variant: ButtonVariant.text,
                onPressed: onDelete,
              ),
            CustomBtn(
              text: isEditing
                  ? LocaleKeys.update_debt.tr()
                  : LocaleKeys.save_debt.tr(),
              onPressed: onSave,
            ),
            SizedBox(height: context.h10),
          ],
        ),
      ),
    );
  }
}
