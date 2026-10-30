import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/components/custom_appbar.dart';
import 'package:masrofy/core/router/go_router.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/screen_helper_extension.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';
import 'package:masrofy/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:masrofy/features/debts/presentation/widget/debets_card_widget.dart';
import 'package:masrofy/features/debts/presentation/widget/debts_bottom_sheet_widget.dart';
import 'package:masrofy/features/debts/presentation/widget/debts_summary_card_widget.dart';
import 'package:masrofy/features/debts/presentation/widget/debts_tab_bar_widget.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DebtsCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.h20),
            child: Column(
              children: [
                CustomAppBar(
                  title: LocaleKeys.debts.tr(),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        DebtsBottomSheetWidget(isEditing: false),
                  ),
                ),
                SizedBox(height: context.h20),
                DebtsSummaryCardWidget(),
                SizedBox(height: context.h25),
                DebtsTabBarWidget(),
                SizedBox(height: context.h25),
                BlocBuilder<DebtsCubit, DebtsStatus>(
                  builder: (context, state) {
                    return _DebtsListView(state: state);
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
  final Object? state;
  const _DebtsListView({required this.state});

  @override
  Widget build(BuildContext context) {
    final filteredDebts = debtsModel.where((debt) {
      if (state == DebtsStatus.isActive) {
        return debt.isActive;
      } else {
        return debt.isPaid;
      }
    }).toList();
    return filteredDebts.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                LocaleKeys.no_debts.tr(),
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredDebts.length,
            separatorBuilder: (context, index) => SizedBox(height: context.h20),
            itemBuilder: (context, index) {
              final debts = filteredDebts[index];
              return DebetsCardWidget(
                debts: debts,
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => DebtsBottomSheetWidget(
                    isEditing: true,
                    onDelete: () => router.pop(),
                  ),
                ),
              );
            },
          );
  }
}
