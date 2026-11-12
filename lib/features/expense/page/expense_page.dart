import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_appbar.dart';
import 'package:masrofy/features/expense/widget/expense_amount_section.dart';
import 'package:masrofy/features/expense/widget/expense_bottom_actions.dart';
import 'package:masrofy/features/expense/widget/expense_category_field.dart';
import 'package:masrofy/features/expense/widget/expense_date_field.dart';
import 'package:masrofy/features/expense/widget/expense_description_section.dart';
import 'package:masrofy/features/expense/widget/image_picker_widget.dart';

class ExpensePage extends StatefulWidget {
  final void Function(
    double amount,
    String category,
    DateTime date,
    String note,
    File? image,
  )?
  onSave;

  const ExpensePage({super.key, this.onSave});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  File? _selectedImage;
  Key _imagePickerKey = UniqueKey();

  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = LocaleKeys.food;

  final List<String> _categories = [
    LocaleKeys.food.tr(),
    LocaleKeys.transportation.tr(),
    LocaleKeys.bills.tr(),
    LocaleKeys.shopping.tr(),
    LocaleKeys.entertainment.tr(),
    LocaleKeys.other.tr(),
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String get _formattedDate {
    final languageCode = context.locale.languageCode;

    final date = DateFormat('d MMMM y', languageCode).format(_selectedDate);

    final time = DateFormat('h:mm a', languageCode).format(_selectedDate);

    return '$date - $time';
  }

  Future<void> _selectCategory() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: context.theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final colors = Theme.of(sheetContext).colorScheme;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.h20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.category.tr(),
                  style: context.textTheme.titleLarge,
                ),
                SizedBox(height: context.h15),
                ..._categories.map(
                  (category) => ListTile(
                    title: Text(category.tr()),
                    trailing: category == _selectedCategory
                        ? Icon(Icons.check_circle, color: colors.primary)
                        : null,
                    onTap: () {
                      Navigator.pop(sheetContext, category);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected == null || !mounted) return;

    setState(() {
      _selectedCategory = selected;
    });
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );

    if (time == null || !mounted) return;

    setState(() {
      _selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void _resetForm() {
    setState(() {
      _amountController.clear();
      _noteController.clear();
      _selectedDate = DateTime.now();
      _selectedCategory = LocaleKeys.food;
      _selectedImage = null;
      _imagePickerKey = UniqueKey();
    });
  }

  void _handleSave({bool addAnother = false}) {
    final amount = double.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.validation_expense_input.tr())),
      );
      return;
    }

    final save = widget.onSave;
    if (save == null) return;

    save(
      amount,
      _selectedCategory,
      _selectedDate,
      _noteController.text.trim(),
      _selectedImage,
    );

    if (addAnother) {
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.h20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(title: LocaleKeys.add_expense.tr()),

              SizedBox(height: context.h20),

              ExpenseAmountSection(controller: _amountController),

              SizedBox(height: context.h20),

              ExpenseCategoryField(
                category: _selectedCategory,
                onTap: _selectCategory,
              ),

              SizedBox(height: context.h15),

              ExpenseDateField(date: _formattedDate, onTap: _selectDateTime),

              SizedBox(height: context.h15),

              ExpenseDescriptionSection(controller: _noteController),

              SizedBox(height: context.h15),

              ImagePickerWidget(
                key: _imagePickerKey,
                onImageSelected: _onImageSelected,
              ),

              SizedBox(height: context.h20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ExpenseBottomActions(
        onSave: _handleSave,
        onSaveAndAdd: () => _handleSave(addAnother: true),
      ),
    );
  }
}
