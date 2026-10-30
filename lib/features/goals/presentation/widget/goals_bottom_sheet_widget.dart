import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_btn.dart';
import 'package:masrofy/core/widgets/custom_text_form_field.dart';

class GoalsBottomSheetWidget extends StatelessWidget {
  final bool isEditing;
  final TextEditingController? titleController;
  final TextEditingController? currentController;
  final TextEditingController? targetController;
  final VoidCallback? onDelete;
  final VoidCallback? onSave;
  const GoalsBottomSheetWidget({
    super.key,
    required this.isEditing,
    this.titleController,
    this.currentController,
    this.targetController,
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
                  ? LocaleKeys.edit_goal.tr()
                  : LocaleKeys.add_new_goal.tr(),
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              labelText: LocaleKeys.goal_name.tr(),
              controller: titleController,
            ),
            CustomTextField(
              labelText: LocaleKeys.current_amount.tr(),
              controller: currentController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              labelText: LocaleKeys.target_amount.tr(),
              controller: targetController,
              keyboardType: TextInputType.number,
            ),
            if (isEditing && onDelete != null)
              CustomBtn(
                text: LocaleKeys.delete_goal.tr(),
                variant: ButtonVariant.text,
                onPressed: onDelete,
              ),
            CustomBtn(
              text: isEditing
                  ? LocaleKeys.update_goal.tr()
                  : LocaleKeys.save_goal.tr(),
              onPressed: onSave,
            ),
            SizedBox(height: context.h10),
          ],
        ),
      ),
    );
  }
}
