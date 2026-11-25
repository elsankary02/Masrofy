import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class IncomeBottomSheetWidget extends StatelessWidget {
  final bool isEditing;
  final TextEditingController? titleController;
  final TextEditingController? amountController;
  final TextEditingController? descriptionController;
  final VoidCallback? onDelete;
  final VoidCallback? onSave;

  const IncomeBottomSheetWidget({
    super.key,
    required this.isEditing,
    this.titleController,
    this.amountController,
    this.descriptionController,
    this.onDelete,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: context.h20,
          bottom: context.viewInsets.bottom + context.h15,
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
                    ? LocaleKeys.edit_income.tr()
                    : LocaleKeys.add_new_income.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                labelText: LocaleKeys.income_name.tr(),
                controller: titleController,
              ),
              CustomTextField(
                labelText: LocaleKeys.amount.tr(),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                labelText: LocaleKeys.description_optional.tr(),
                controller: descriptionController,
                keyboardType: TextInputType.text,
              ),
              if (isEditing && onDelete != null)
                CustomBtn(
                  text: LocaleKeys.delete_income.tr(),
                  variant: ButtonVariant.text,
                  onPressed: onDelete,
                ),
              CustomBtn(
                text: isEditing
                    ? LocaleKeys.update_income.tr()
                    : LocaleKeys.save_income.tr(),
                onPressed: onSave,
              ),
              SizedBox(height: context.h10),
            ],
          ),
        ),
      ),
    );
  }
}
