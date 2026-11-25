import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/datasource/expense_local_datasource.dart';
import '../../data/repo/expense_repository_impl.dart';
import '../../domain/entities/expense_entity.dart';
import '../../domain/usecase/get_expenses_usecases.dart';
import '../cubit/expense_cubit.dart';
import '../widget/expense_amount_section.dart';
import '../widget/expense_bottom_actions.dart';
import '../widget/expense_category_field.dart';
import '../widget/expense_date_field.dart';
import '../widget/expense_description_section.dart';
import '../widget/image_picker_widget.dart';

class ExpensePage extends StatefulWidget {
  final void Function(
    double amount,
    String categoryKey,
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
  late final ExpenseCubit _expenseCubit;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  File? _selectedImage;
  Key _imagePickerKey = UniqueKey();

  DateTime _selectedDate = DateTime.now();
  String _selectedCategoryKey = LocaleKeys.food;

  static const List<String> _categoryKeys = [
    LocaleKeys.food,
    LocaleKeys.transportation,
    LocaleKeys.bills,
    LocaleKeys.shopping,
    LocaleKeys.entertainment,
    LocaleKeys.other,
  ];

  @override
  void initState() {
    super.initState();
    final repository = ExpenseRepositoryImpl(ExpenseLocalDataSourceImpl());
    _expenseCubit = ExpenseCubit(
      getExpensesUseCase: GetExpensesUseCase(repository),
      addExpenseUseCase: AddExpenseUseCase(repository),
      deleteExpenseUseCase: DeleteExpenseUseCase(repository),
    )..loadExpenses();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _expenseCubit.close();
    super.dispose();
  }

  String get _formattedDate {
    final languageCode = context.locale.languageCode;
    final date = DateFormat('d MMMM y', languageCode).format(_selectedDate);
    final time = DateFormat('h:mm a', languageCode).format(_selectedDate);
    return '$date - $time';
  }

  void _showValidationMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> _selectCategory() async {
    final selectedKey = await showModalBottomSheet<String>(
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
                ..._categoryKeys.map(
                  (key) => ListTile(
                    title: Text(key.tr()),
                    trailing: key == _selectedCategoryKey
                        ? Icon(Icons.check_circle, color: colors.primary)
                        : null,
                    onTap: () {
                      Navigator.pop(sheetContext, key);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedKey == null || !mounted) return;

    setState(() {
      _selectedCategoryKey = selectedKey;
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
      _selectedCategoryKey = LocaleKeys.food;
      _selectedImage = null;
      _imagePickerKey = UniqueKey();
    });
  }

  Future<void> _handleSave({bool addAnother = false}) async {
    final rawAmount = _amountController.text.trim();
    if (rawAmount.isEmpty) {
      _showValidationMessage(
        LocaleKeys.validation_expense_amount_required.tr(),
      );
      return;
    }

    final amount = double.tryParse(rawAmount);
    if (amount == null) {
      _showValidationMessage(LocaleKeys.validation_expense_amount_invalid.tr());
      return;
    }

    if (amount <= 0) {
      _showValidationMessage(
        LocaleKeys.validation_expense_amount_positive.tr(),
      );
      return;
    }

    final note = _noteController.text.trim();
    final entity = ExpenseEntity(
      id: '',
      amount: amount,
      categoryKey: _selectedCategoryKey,
      date: _selectedDate,
      note: note,
      imagePath: _selectedImage?.path,
    );

    await _expenseCubit.addExpense(entity);
    widget.onSave?.call(
      amount,
      _selectedCategoryKey,
      _selectedDate,
      note,
      _selectedImage,
    );

    if (!mounted) return;

    if (addAnother) {
      _resetForm();
    } else {
      Navigator.maybePop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _expenseCubit,
      child: Scaffold(
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
                  category: _selectedCategoryKey,
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
          onSave: () => _handleSave(),
          onSaveAndAdd: () => _handleSave(addAnother: true),
        ),
      ),
    );
  }
}
