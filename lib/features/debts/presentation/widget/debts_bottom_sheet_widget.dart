import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_btn.dart';
import 'package:masrofy/core/widgets/custom_text_form_field.dart';

class DebtsBottomSheetWidget extends StatefulWidget {
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
  State<DebtsBottomSheetWidget> createState() => _DebtsBottomSheetWidgetState();
}

class _DebtsBottomSheetWidgetState extends State<DebtsBottomSheetWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation_debt_title_required.tr();
    }
    return null;
  }

  String? _validateTotal(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return LocaleKeys.validation_debt_total_required.tr();
    }
    final parsed = num.tryParse(text);
    if (parsed == null) {
      return LocaleKeys.validation_debt_total_invalid.tr();
    }
    if (parsed <= 0) {
      return LocaleKeys.validation_debt_total_positive.tr();
    }
    return null;
  }

  String? _validatePaid(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    final parsed = num.tryParse(text);
    if (parsed == null) {
      return LocaleKeys.validation_debt_paid_invalid.tr();
    }
    if (parsed < 0) {
      return LocaleKeys.validation_debt_paid_negative.tr();
    }
    final total = num.tryParse(widget.totalController?.text.trim() ?? '');
    if (total != null && parsed > total) {
      return LocaleKeys.validation_debt_paid_exceeds_total.tr();
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: context.h20,
        bottom: context.viewInsets.bottom,
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
                    ? LocaleKeys.edit_debt.tr()
                    : LocaleKeys.add_new_debt.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                labelText: LocaleKeys.debt_title.tr(),
                controller: widget.titleController,
                validator: _validateTitle,
              ),
              CustomTextField(
                labelText: LocaleKeys.creditor.tr(),
                controller: widget.creditorController,
              ),
              CustomTextField(
                labelText: LocaleKeys.current_amount.tr(),
                controller: widget.totalController,
                keyboardType: TextInputType.number,
                validator: _validateTotal,
              ),
              CustomTextField(
                labelText: LocaleKeys.paid_amount.tr(),
                controller: widget.paidController,
                keyboardType: TextInputType.number,
                validator: _validatePaid,
              ),
              if (widget.isEditing && widget.onDelete != null)
                CustomBtn(
                  text: LocaleKeys.delete_debt.tr(),
                  variant: ButtonVariant.text,
                  onPressed: widget.onDelete,
                ),
              CustomBtn(
                text: widget.isEditing
                    ? LocaleKeys.update_debt.tr()
                    : LocaleKeys.save_debt.tr(),
                onPressed: _handleSave,
              ),
              SizedBox(height: context.h10),
            ],
          ),
        ),
      ),
    );
  }
}
