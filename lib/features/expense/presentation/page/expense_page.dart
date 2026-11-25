import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
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

class ExpensePage extends StatefulWidget {
  final void Function(
    double amount,
    String categoryKey,
    DateTime date,
    String note,
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

  ({IconData icon, Color color}) _categoryVisual(String key) {
    final normalized = key.trim().toLowerCase();
    if (normalized.contains('food') || key == LocaleKeys.food) {
      return (icon: Icons.restaurant_rounded, color: AppColors.orange);
    }
    if (normalized.contains('transport') || key == LocaleKeys.transportation) {
      return (icon: Icons.directions_car_rounded, color: AppColors.blue);
    }
    if (normalized.contains('bill') || key == LocaleKeys.bills) {
      return (icon: Icons.receipt_long_rounded, color: AppColors.purple);
    }
    if (normalized.contains('shop') || key == LocaleKeys.shopping) {
      return (icon: Icons.shopping_bag_rounded, color: AppColors.success);
    }
    if (normalized.contains('entertain') || key == LocaleKeys.entertainment) {
      return (icon: Icons.movie_rounded, color: AppColors.expense);
    }
    return (icon: Icons.category_rounded, color: AppColors.primary);
  }

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
    final date = DateFormat('d MMM y', languageCode).format(_selectedDate);
    final time = DateFormat('h:mm a', languageCode).format(_selectedDate);
    return '$date • $time';
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
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isDark = Theme.of(sheetContext).brightness == Brightness.dark;
        final surfaceColor = isDark ? const Color(0xFF181C20) : Colors.white;
        final borderColor = isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.08);

        return Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(top: BorderSide(color: borderColor)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.h20,
                12,
                context.h20,
                context.h20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.category.tr(),
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        icon: const Icon(Icons.close_rounded, size: 20),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _categoryKeys.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.7,
                        ),
                    itemBuilder: (context, index) {
                      final key = _categoryKeys[index];
                      final isSelected = key == _selectedCategoryKey;
                      final visual = _categoryVisual(key);

                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Navigator.pop(sheetContext, key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? visual.color.withValues(alpha: 0.14)
                                : (isDark
                                      ? Colors.white.withValues(alpha: 0.03)
                                      : const Color(0xFFF7F8FA)),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? visual.color : borderColor,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: visual.color.withValues(
                                  alpha: 0.16,
                                ),
                                child: Icon(
                                  visual.icon,
                                  size: 17,
                                  color: visual.color,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  key.tr(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected ? visual.color : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
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

  void _resetForm() {
    setState(() {
      _amountController.clear();
      _noteController.clear();
      _selectedDate = DateTime.now();
      _selectedCategoryKey = LocaleKeys.food;
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
    );

    await _expenseCubit.addExpense(entity);
    widget.onSave?.call(amount, _selectedCategoryKey, _selectedDate, note);

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
