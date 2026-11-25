import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/datasources/debts_local_datasource.dart';
import '../../data/repositories/debts_repository_impl.dart';
import '../../domain/entities/debt_entity.dart';
import '../../domain/usecases/get_debts_usecase.dart';
import '../cubit/debts_cubit.dart';
import '../cubit/debts_state.dart';
import '../widget/debets_card_widget.dart';
import '../widget/debts_bottom_sheet_widget.dart';
import '../widget/debts_summary_card_widget.dart';
import '../widget/debts_tab_bar_widget.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key});

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  late final DebtsCubit _debtsCubit;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _creditorController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final repository = DebtsRepositoryImpl(DebtsLocalDataSourceImpl());
    _debtsCubit = DebtsCubit(
      getDebtsUseCase: GetDebtsUseCase(repository),
      addDebtUseCase: AddDebtUseCase(repository),
      updateDebtUseCase: UpdateDebtUseCase(repository),
      deleteDebtUseCase: DeleteDebtUseCase(repository),
    )..loadDebts();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _creditorController.dispose();
    _totalController.dispose();
    _paidController.dispose();
    _debtsCubit.close();
    super.dispose();
  }

  void _showValidationMessage(BuildContext targetContext, String message) {
    ScaffoldMessenger.of(targetContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _openDebtForm({DebtEntity? debt}) {
    final isEditing = debt != null;
    final initialPaid = debt == null ? '' : debt.paidAmount.toString();

    _titleController.text = debt?.title ?? '';
    _creditorController.text = debt?.subtitle ?? '';
    _totalController.text = debt?.target.toString() ?? '';
    _paidController.text = initialPaid;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return BlocProvider.value(
          value: _debtsCubit,
          child: DebtsBottomSheetWidget(
            isEditing: isEditing,
            titleController: _titleController,
            creditorController: _creditorController,
            totalController: _totalController,
            paidController: _paidController,
            onDelete: isEditing
                ? () async {
                    await _debtsCubit.deleteDebt(debt.id);
                    if (!sheetContext.mounted) return;
                    Navigator.pop(sheetContext);
                  }
                : null,
            onSave: () async {
              final title = _titleController.text.trim();
              final subtitle = _creditorController.text.trim();
              final totalText = _totalController.text.trim();
              final paidText = _paidController.text.trim();

              if (title.isEmpty) {
                _showValidationMessage(
                  context,
                  LocaleKeys.validation_debt_title_required.tr(),
                );
                return;
              }

              final num? parsedTotal = totalText.isEmpty
                  ? null
                  : num.tryParse(totalText);
              if (parsedTotal == null) {
                _showValidationMessage(
                  context,
                  LocaleKeys.validation_debt_total_invalid.tr(),
                );
                return;
              }

              if (parsedTotal <= 0) {
                _showValidationMessage(
                  context,
                  LocaleKeys.validation_debt_total_positive.tr(),
                );
                return;
              }

              final num? parsedPaid = paidText.isEmpty
                  ? 0
                  : num.tryParse(paidText);
              if (parsedPaid == null) {
                _showValidationMessage(
                  context,
                  LocaleKeys.validation_debt_paid_invalid.tr(),
                );
                return;
              }

              if (parsedPaid < 0) {
                _showValidationMessage(
                  context,
                  LocaleKeys.validation_debt_paid_negative.tr(),
                );
                return;
              }

              if (parsedPaid > parsedTotal) {
                _showValidationMessage(
                  context,
                  LocaleKeys.validation_debt_paid_exceeds_total.tr(),
                );
                return;
              }

              final remaining = (parsedTotal - parsedPaid).clamp(
                0,
                parsedTotal,
              );
              final palette = [
                AppColors.error.toARGB32(),
                AppColors.saving.toARGB32(),
                AppColors.cyan.toARGB32(),
              ];
              final cardColorValue =
                  debt?.colorValue ??
                  palette[_debtsCubit.state.debts.length % palette.length];

              final item = DebtEntity(
                id: debt?.id ?? '',
                title: title,
                subtitle: subtitle,
                current: remaining,
                target: parsedTotal,
                colorValue: cardColorValue,
              );

              if (isEditing) {
                await _debtsCubit.updateDebt(item);
              } else {
                await _debtsCubit.addDebt(item);
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
      value: _debtsCubit,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.h20),
            child: Column(
              children: [
                CustomAppBar(
                  title: LocaleKeys.debts.tr(),
                  onPressed: () => _openDebtForm(),
                ),
                SizedBox(height: context.h20),
                const DebtsSummaryCardWidget(),
                SizedBox(height: context.h25),
                const DebtsTabBarWidget(),
                SizedBox(height: context.h25),
                BlocBuilder<DebtsCubit, DebtsState>(
                  builder: (context, state) {
                    return _DebtsListView(
                      debts: state.debts,
                      status: state.status,
                      onEdit: (debt) => _openDebtForm(debt: debt),
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

class _DebtsListView extends StatelessWidget {
  final List<DebtEntity> debts;
  final DebtsStatus status;
  final ValueChanged<DebtEntity> onEdit;

  const _DebtsListView({
    required this.debts,
    required this.status,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final filteredDebts = debts.where((debt) {
      if (status == DebtsStatus.isActive) {
        return debt.isActive;
      } else {
        return debt.isPaid;
      }
    }).toList();

    if (filteredDebts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            LocaleKeys.no_debts.tr(),
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
      itemCount: filteredDebts.length,
      separatorBuilder: (context, index) => SizedBox(height: context.h20),
      itemBuilder: (context, index) {
        final debt = filteredDebts[index];
        return DebetsCardWidget(debts: debt, onTap: () => onEdit(debt));
      },
    );
  }
}
