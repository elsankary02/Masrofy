import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/extensions/screen_helper_extension.dart';
import '../../../../../../core/widgets/popup_menu_date_filter_widget.dart';
import '../../domain/entities/transaction_entity.dart';
import '../cubit/transactions_cubit.dart';
import '../cubit/transactions_state.dart';

class TransactionsSummaryCardWidget extends StatelessWidget {
  const TransactionsSummaryCardWidget({super.key});

  TransactionDateFilter _mapFilter(dynamic value) {
    final raw = value?.toString().toLowerCase() ?? '';
    if (raw.contains('today')) return TransactionDateFilter.today;
    if (raw.contains('week')) return TransactionDateFilter.week;
    if (raw.contains('month')) return TransactionDateFilter.month;
    return TransactionDateFilter.all;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.##');

    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsetsDirectional.all(context.h20),
          decoration: BoxDecoration(
            gradient: AppColors.walletGradient,
            borderRadius: BorderRadiusDirectional.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.total_expenses.tr(),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      formatter.format(state.totalExpenses),
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: context.h15),
                    PopupMenuDateFilterWidget(
                      onFilterChanged: (value) {
                        context.read<TransactionsCubit>().changeFilter(
                          _mapFilter(value),
                        );
                      },
                      borderColor: Colors.transparent,
                      color: AppColors.white.withValues(alpha: 0.15),
                      iconColor: AppColors.white,
                      titleColor: AppColors.white,
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppImages.goals,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}
