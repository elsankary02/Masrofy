import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/datasource/income_local_datasource.dart';
import '../../data/repo/income_repository_impl.dart';
import '../../domain/entities/income_entity.dart';
import '../../domain/usecases/get_incomes_usecase.dart';
import '../cubit/income_cubit.dart';
import '../cubit/income_state.dart';
import '../widget/income_bottom_sheet_widget.dart';
import '../widget/income_item_widget.dart';
import '../widget/income_summary_card_widget.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  late final IncomeCubit _incomeCubit;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final repository = IncomeRepositoryImpl(IncomeLocalDataSourceImpl());
    _incomeCubit = IncomeCubit(
      getIncomesUseCase: GetIncomesUseCase(repository),
      addIncomeUseCase: AddIncomeUseCase(repository),
      updateIncomeUseCase: UpdateIncomeUseCase(repository),
      deleteIncomeUseCase: DeleteIncomeUseCase(repository),
    )..loadIncomes();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _incomeCubit.close();
    super.dispose();
  }

  void _showValidationSnackBar(BuildContext targetContext, String message) {
    ScaffoldMessenger.of(targetContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _openIncomeForm({IncomeEntity? income}) {
    final isEditing = income != null;
    _titleController.text = income?.title ?? '';
    _amountController.text = income == null ? '' : income.amount.toString();
    _descriptionController.text = income?.subtitle ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return BlocProvider.value(
          value: _incomeCubit,
          child: IncomeBottomSheetWidget(
            isEditing: isEditing,
            titleController: _titleController,
            amountController: _amountController,
            descriptionController: _descriptionController,
            onDelete: isEditing
                ? () async {
                    await _incomeCubit.deleteIncome(income.id);
                    if (!sheetContext.mounted) return;
                    Navigator.pop(sheetContext);
                  }
                : null,
            onSave: () async {
              final title = _titleController.text.trim();
              final amountText = _amountController.text.trim();
              final description = _descriptionController.text.trim();
              final num? parsedAmount = amountText.isEmpty
                  ? null
                  : num.tryParse(amountText);

              if (title.isEmpty) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_income_title_required.tr(),
                );
                return;
              }

              if (parsedAmount == null) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_income_amount_invalid.tr(),
                );
                return;
              }

              if (parsedAmount <= 0) {
                _showValidationSnackBar(
                  context,
                  LocaleKeys.validation_income_amount_positive.tr(),
                );
                return;
              }

              final palette = [
                AppColors.income,
                AppColors.accent,
                AppColors.primary,
              ];
              final selectedColor = income != null
                  ? Color(income.iconColorValue)
                  : palette[_incomeCubit.state.incomes.length % palette.length];
              final selectedIconKey = income?.iconKey ?? 'trending_up';

              final item = IncomeEntity(
                id: income?.id ?? '',
                title: title,
                subtitle: description,
                frequency: income?.frequency ?? '',
                amount: parsedAmount.toInt(),
                iconKey: selectedIconKey,
                iconColorValue: selectedColor.toARGB32(),
              );

              if (isEditing) {
                await _incomeCubit.updateIncome(item);
              } else {
                await _incomeCubit.addIncome(item);
              }

              if (!sheetContext.mounted) return;
              Navigator.pop(sheetContext);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _incomeCubit,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.h20),
            child: Column(
              children: [
                CustomAppBar(
                  title: LocaleKeys.income_sources.tr(),
                  onPressed: () => _openIncomeForm(),
                ),
                SizedBox(height: context.h20),
                const IncomeSummaryCardWidget(),
                SizedBox(height: context.h30),
                BlocBuilder<IncomeCubit, IncomeState>(
                  builder: (context, state) {
                    if (state.isLoading && state.incomes.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: context.h40),
                        child: const CircularProgressIndicator(),
                      );
                    }
                    return _IncomeListView(
                      incomes: state.incomes,
                      onEdit: (income) => _openIncomeForm(income: income),
                    );
                  },
                ),
                SizedBox(height: context.h60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IncomeListView extends StatelessWidget {
  final List<IncomeEntity> incomes;
  final ValueChanged<IncomeEntity> onEdit;

  const _IncomeListView({required this.incomes, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    if (incomes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            LocaleKeys.no_income_this_month.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: incomes.length,
      separatorBuilder: (context, index) => SizedBox(height: context.h20),
      itemBuilder: (context, index) {
        final item = incomes[index];
        return IncomeItemWidget(income: item, onTap: () => onEdit(item));
      },
    );
  }
}
