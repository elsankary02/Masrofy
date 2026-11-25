import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class GoalsBottomSheetWidget extends StatefulWidget {
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
  State<GoalsBottomSheetWidget> createState() => _GoalsBottomSheetWidgetState();
}

class _GoalsBottomSheetWidgetState extends State<GoalsBottomSheetWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation_goal_title_required.tr();
    }
    return null;
  }

  String? _validateCurrent(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    final parsed = num.tryParse(text);
    if (parsed == null) {
      return LocaleKeys.validation_goal_current_invalid.tr();
    }
    if (parsed < 0) {
      return LocaleKeys.validation_goal_current_negative.tr();
    }
    return null;
  }

  String? _validateTarget(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return LocaleKeys.validation_goal_target_required.tr();
    }
    final parsed = num.tryParse(text);
    if (parsed == null) {
      return LocaleKeys.validation_goal_target_invalid.tr();
    }
    if (parsed <= 0) {
      return LocaleKeys.validation_goal_target_positive.tr();
    }
    return null;
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    widget.onSave?.call();
  }

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
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: context.h20,
              children: [
                Text(
                  widget.isEditing
                      ? LocaleKeys.edit_goal.tr()
                      : LocaleKeys.add_new_goal.tr(),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextField(
                  labelText: LocaleKeys.goal_name.tr(),
                  controller: widget.titleController,
                  validator: _validateTitle,
                ),
                CustomTextField(
                  labelText: LocaleKeys.current_amount.tr(),
                  controller: widget.currentController,
                  keyboardType: TextInputType.number,
                  validator: _validateCurrent,
                ),
                CustomTextField(
                  labelText: LocaleKeys.target_amount.tr(),
                  controller: widget.targetController,
                  keyboardType: TextInputType.number,
                  validator: _validateTarget,
                ),
                if (widget.isEditing && widget.onDelete != null)
                  CustomBtn(
                    text: LocaleKeys.delete_goal.tr(),
                    variant: ButtonVariant.text,
                    onPressed: widget.onDelete,
                  ),
                CustomBtn(
                  text: widget.isEditing
                      ? LocaleKeys.update_goal.tr()
                      : LocaleKeys.save_goal.tr(),
                  onPressed: _handleSave,
                ),
                SizedBox(height: context.h10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
