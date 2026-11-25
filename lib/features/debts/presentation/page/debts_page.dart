import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/core/widgets/custom_appbar.dart';
import 'package:masrofy/features/debts/data/datasources/debts_local_datasource.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';
import 'package:masrofy/features/debts/data/repositories/debts_repository_impl.dart';
import 'package:masrofy/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:masrofy/features/debts/presentation/cubit/debts_state.dart';
import 'package:masrofy/features/debts/presentation/widget/debets_card_widget.dart';
import 'package:masrofy/features/debts/presentation/widget/debts_bottom_sheet_widget.dart';
import 'package:masrofy/features/debts/presentation/widget/debts_summary_card_widget.dart';
import 'package:masrofy/features/debts/presentation/widget/debts_tab_bar_widget.dart';

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
    _debtsCubit = DebtsCubit(DebtsRepositoryImpl(DebtsLocalDataSourceImpl()))
      ..loadDebts();
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

  void _openDebtForm({DebtsModel? debt}) {
    final isEditing = debt != null;
    final initialPaid = debt == null
        ? ''
        : (debt.target - debt.current).clamp(0, debt.target).toString();

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

              final num? parsedTotal = totalText.isEmpty
                  ? null
                  : num.tryParse(totalText);
              final num? parsedPaid = paidText.isEmpty
                  ? 0
                  : num.tryParse(paidText);

              if (title.isEmpty) {
                _showValidationMessage(context, 'أدخل عنوانًا صحيحًا للدين');
                return;
              }

              if (parsedTotal == null || parsedTotal <= 0) {
                _showValidationMessage(
                  context,
                  'المبلغ الإجمالي يجب أن يكون رقمًا موجبًا أكبر من صفر',
                );
                return;
              }

              if (parsedPaid == null || parsedPaid < 0) {
                _showValidationMessage(
                  context,
                  'لا يُسمح بإدخال مبلغ مدفوع بالسالب',
                );
                return;
              }

              if (parsedPaid > parsedTotal) {
                _showValidationMessage(
                  context,
                  'المبلغ المدفوع لا يمكن أن يتجاوز المبلغ الإجمالي',
                );
                return;
              }

              final remaining = (parsedTotal - parsedPaid).clamp(
                0,
                parsedTotal,
              );
              final palette = [
                AppColors.error,
                AppColors.saving,
                AppColors.cyan,
              ];
              final cardColor =
                  debt?.color ??
                  palette[_debtsCubit.state.debts.length % palette.length];

              final item = DebtsModel(
                id: debt?.id ?? '',
                title: title,
                subtitle: subtitle,
                current: remaining,
                target: parsedTotal,
                color: cardColor,
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
  final List<DebtsModel> debts;
  final DebtsStatus status;
  final ValueChanged<DebtsModel> onEdit;

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
            style: TextStyle(color: Colors.grey.shade400),
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
